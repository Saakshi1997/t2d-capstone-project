"""
03_opentargets_benchmark.py

Step 3: Query Open Targets Genetics/Platform for their locus-to-gene (L2G)
prediction at the TCF7L2 locus, and compare against your own SuSiE + coloc
result.

Question this script answers: does an independent, ML-based method agree with
your statistical-genetics-based pipeline about which gene this locus acts
through? Agreement is a nice sanity check; disagreement is a legitimate,
interesting finding to reason about (different tissue weighting, different
data vintage, different modeling assumptions) — not a bug to fix until it
goes away.

STATUS: stub — week 7 focus.
"""

import requests
import pandas as pd

OT_GRAPHQL_URL = "https://api.platform.opentargets.org/api/v4/graphql"

VARIANT_ID = "rs7903146"  # or the build-specific variant ID Open Targets expects


def query_l2g(variant_id: str) -> dict:
    """
    Query Open Targets for locus-to-gene predictions at a variant.
    Check the current schema at https://platform-docs.opentargets.org/data-access/graphql-api
    before finalizing this query — the API has changed shape across versions.
    """
    query = """
    query L2G($variantId: String!) {
      variantInfo(variantId: $variantId) {
        id
        # TODO: fill in the actual L2G / credible set fields once you've
        # checked the current schema in GraphiQL:
        # https://api.platform.opentargets.org/api/v4/graphql/browser
      }
    }
    """
    resp = requests.post(
        OT_GRAPHQL_URL,
        json={"query": query, "variables": {"variantId": variant_id}},
        timeout=30,
    )
    resp.raise_for_status()
    return resp.json()


def main():
    result = query_l2g(VARIANT_ID)
    # TODO: parse result into a tidy DataFrame of gene / L2G score
    # df = pd.DataFrame(...)
    # df.to_csv("results/tables/opentargets_l2g_tcf7l2.csv", index=False)
    print(result)


if __name__ == "__main__":
    main()
