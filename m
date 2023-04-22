Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB818C77B78
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 22:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDVWEQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDVWEO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 18:04:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07675268E
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682201031; x=1713737031;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2j88vnk59Ii8I8BZTtjvjiMXWK14PUGimeu52WCdjv8=;
  b=JAoO/7IaBud4ehKKgapUrXT1/RCmdTalKUkbbouRDcSJ7DVUk2ACAgAK
   KatU7RlgMwNtkyMbz5d36iEDPDQolynXYv2P1ap49WL+hREoRIjKi5Qyh
   p30pm/aY1ibGYe25E9AZsyWoa84TOrmelIsLl5OYMiRV5PD62ikylaNdw
   QDTQNsFD39TZNzQhU5NJFYj3sYuXU+PLMraOD5GQAWxfHd+hcskJfJA+L
   GVWB7pjabT9+PvFGXlyY7XHa0iueotELtkOIOnVqE5NNlDfwvuFoS76eO
   SzAYD3RJswpB5oG2UmtmnuPAEDCx/u/a7kBHv9vNwLUTUP4DiznccoiBw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="432480969"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="432480969"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 15:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="938851464"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="938851464"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2023 15:03:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 15:03:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 15:03:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 22 Apr 2023 15:03:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 22 Apr 2023 15:03:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1ZRMM5uyhzfmI8Fm/+2TfSK+foGfcL2+Vnk6XiOPDwAtOQsjg1l/WPYhEbR3jlFDzRpa1mIRq3gIOZ9PLCFKjlGmOcDpmM1k4JA2V00xKz5oFtJvvvGPrDs4mJsTDOJfN7t5e2rEtHIFap+dXbb4QDG7IuVLzTY0l6fddPgzGEtqovORPPYHMJJBrXWxD2nlWk76OwK8WQk+k4N9Vps0L4HwAMtEb1VkrFYJCrQrKsCI5DZknP2V0gdidcAPBBOEPjaJ74nujWcklwdzOoyy3Ka5intpzahh/PQC014Jk8iuAP3K8/tGFaVKqsz7i3j9mavAwGjNjbpev1gBnBCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxc8SIr33fcuiyGzTJzwtqyEzX2asWacERo5RIzRvzM=;
 b=jVjLF10tsMA0AF0+s72hjUaZ2/hX+EjOyrgBFmy7/nLFzqJtsBidbaPu+DMbkOtqpA23JnifETKsJmydkUBsoC1ECFfsDPClqo3ouXELiuQADm2B8RiN5XEi/ZJ7pxO9P0y5iZRGJtq5dXO3TfgqNdxkhXrMHIaJp2NQeV1PK8zzz2ZBcIiwbeDVIT3BV9dJEp+sGTdx4pCk/vc8Wy9tfg05hW0F1H8+mZGjVRAMmD6FAhr+cA7K7XTsukDaIiRTFcybG2NeT5fSTd1LlCqcy5ex7m3VVOCpSCMqoyQ7LNaUNd2fCUsII8YqABCvgixhxgGCKA079KQvQv8d/xgn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8237.namprd11.prod.outlook.com (2603:10b6:610:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.29; Sat, 22 Apr
 2023 22:03:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Sat, 22 Apr 2023
 22:03:45 +0000
Date:   Sat, 22 Apr 2023 15:03:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v6 08/10] tools/testing/cxl: Use injected poison for get
 poison list
Message-ID: <644459be2aa5d_1b66294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681874357.git.alison.schofield@intel.com>
 <0f4242c81821f4982b02cb1009c22783ef66b2f1.1681874357.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f4242c81821f4982b02cb1009c22783ef66b2f1.1681874357.git.alison.schofield@intel.com>
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c7af4e-d696-468c-06a9-08db437d70dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNUCO68dn3Fnsj/GyQtqHvgGbEHCaMk75QZ67atr2VyR0WbbNNjbaw5XeePuDt5D6C4qGN1XdVWfAKCVyW34uliRaZJT84YEVvBW1U3iCDnDQKrkqRF5RMAQiCa1cQFdFjQet9yeH6x2US33cD4nIlNw0EBoznz2tQegZzfCEnT9VJv4AzH3H+igitX1NZSqO8GoXy8htOaxAA0uzY3attrztAdSYvrRIS+/WvOXv86DIm+vvpy1iXEXjP0QQ/yUOA6YdUZHyUdirby4kM24f7beEYOXhwDc2n1l38tKKPy5oOVwFvrjrnRgkAABqhcuTY9G8a0kYXBDgMmRXUo/V5r5+3Mt06plLnhnpgEgnM2VSFRAqW65lxbnxnxMV1hFyM7Ku1yT8SPWQGFDW9K4W1uwlrodvokMTc7NPgZZstEvrpJtkIXXCLb+xWGba01MZUGfTvr6gBePXRRZn0fpqh8yGRk1rMk4iBpW/Sc3jSXMxXOLl+96dL4cgvRSJU0yEpjFiQCsA4o9eD2bTl08A6zhjHlfT0WC2JXVbW6TbiVCzgWw2C8JYH77neAWxjiK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(2906002)(5660300002)(26005)(6506007)(6512007)(9686003)(41300700001)(83380400001)(8676002)(8936002)(38100700002)(82960400001)(316002)(66476007)(66556008)(66946007)(4326008)(186003)(6636002)(86362001)(110136005)(6666004)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IN7XqVxoyUg1WV0u3Q7Ue5U/wBdEDDuBjPT8cCJvtDoArowR0d/mRjqri2z2?=
 =?us-ascii?Q?OCQDg/nLtIedhiFTmToaIzKpmr5hqkpcTNFy4Ddy1HVMZ7Jhicm9qwuTfiEe?=
 =?us-ascii?Q?P4ploPfvd/xqwbCPsoV/Smm4t0qhkmPL4YA6wkTE5M0y1L3Z6PxChf0quyRr?=
 =?us-ascii?Q?SdueNen08ZLUyNzq15p1zD50RAX2da/ZJmGLeGEK+qXPAbu84/lU40vJ7oZ5?=
 =?us-ascii?Q?gQBSF33v+wAmeMNoVe9rc+UfsPX6yg6mkf5r/47QO+7PdFR0ZZnr+VDTlyyF?=
 =?us-ascii?Q?cu+4q6n7+EKwI68lBcFVUlhKI+S/oOWz1iX0p5dZ6eugxDp0t/XKyJ9MSu5z?=
 =?us-ascii?Q?jbPEraooLHZqYI0nE5WNiwzHcsRzxAnOFEmX9rE49rmRglnwXJKFrX2JkfAd?=
 =?us-ascii?Q?obE9BOOzDO1l4eSWxNKcqU9FHHMQLeyufNtOsl+JnwjzyeCXEf54Tx0+E5R1?=
 =?us-ascii?Q?beLwQoHUgVdDQKs00v7IjqcM8GaLKn/5GFzEu6gKvV8rUHcz/zIPRIi/Q9cY?=
 =?us-ascii?Q?j5YDhtFp/OOXf0BN21vOazhFf5Sxo247xrZMRl7qk8vJTgydi/HArEVfic/s?=
 =?us-ascii?Q?2Z33vQHWfFSNMtkekX4snQsdoS6CRPmyCJ2eHBM0s8wIpkGlGJyFqtOScYD0?=
 =?us-ascii?Q?Z+rsR1MfrHFWY+RTQKtYKwdTWxayw/8iFN1lWVmCOEvaMi4Ife0lHUGEKDLO?=
 =?us-ascii?Q?4UJkyd7kY8mz7N2JNyokK6wfxQp6wfElc6rbfJiUr3N3stuQTT5svTPuAnz8?=
 =?us-ascii?Q?YppDDqov46gxTUfXVG8IwAJXkLJ6FR36gRS6tVGNTWo+ILtim2pyC1glQ6lq?=
 =?us-ascii?Q?3VPWNtbL9CpUAl0H6OlJOzLiLW1Z4SkMEvz0NBNWUAE4ON89iTgx2k+NdoBd?=
 =?us-ascii?Q?leca59tYAzrcctRy4uMXmAJBbtZM8Ob812Hg30SF4nl4YLTgERqj3qi5gLnh?=
 =?us-ascii?Q?E14+lbARAlysbCV+QsNllzKDvEK8I4Ae09shBajnv5LQ7Q0gee8a5gqKjWrT?=
 =?us-ascii?Q?qWwfh9s1JmiaNloW+YHgalabRb0drLgSJsDUshwlmkbVLWbgTrgEiZzV0sga?=
 =?us-ascii?Q?Qa7KV/VrTxEytaQXWkyLQNL6OjgSeKSAWNDSDXdEX1rQyPl/Anc45vPyo14b?=
 =?us-ascii?Q?ux+71xRnXCWXURB9WXWiFwkTT8wTLS/AFO4rjbIXxBp4n1ydBWCydpYjOO7f?=
 =?us-ascii?Q?IKDuAt+6cXa7+HLcO8bbkws5gJIEBxl8aKVNA5ojr6BwbBLWZqoaGMjZn9K4?=
 =?us-ascii?Q?tlDgxZCIo1d0PN1ZFx8kbYZElXWuAcE942VQ5Ha1eLFZKeVoMd9aEKI56qJt?=
 =?us-ascii?Q?4DbKGrjLS8Zd4wvGvDkSXj7ZcQ5UaSEaLd1bTuyZPoU13yGN/Hd9kqpQnRG9?=
 =?us-ascii?Q?qXcDi/jSvI85Zem63LlbNJbm+r5roZ9kTkN/chrbYi0uaiXUQL4pNm5okYfH?=
 =?us-ascii?Q?xNpumBX77VWQoEiVAcdh4N5QuaBWiGy37zhLiKxxHTHG+Vj2tnYSoPiMcLf0?=
 =?us-ascii?Q?QTt4w7KHDK70efWAFTdRUgIotqDc4hNhSFc94rXIgiBdOWr8eREsI55XnGoz?=
 =?us-ascii?Q?XYChIbv5japr0OnPXN4kYxoYXVUwl/b2z/d8NUdy+Ei+ZKM3ccALCwkU83eC?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c7af4e-d696-468c-06a9-08db437d70dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 22:03:44.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAArvynZ2ERetMLJptRwwhDtpP7uuAMU4MnpyYkaboKjNA/0phJxXbRH7bMKWZZv8iMhQGwJWaEm1rOmbvQyGNti3kqH76vMCX7Fuoc39Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8237
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Prior to poison inject support, the mock of 'Get Poison List'
> returned a poison list containing a single mocked error record.
> 
> Following the addition of poison inject and clear support to the
> mock driver, use the mock_poison_list[], rather than faking an
> error record. Mock_poison_list[] list tracks the actual poison
> inject and clear requests issued by userspace.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 59 ++++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 3c3909d30d03..cce7ec8f0efb 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -912,31 +912,52 @@ static struct mock_poison {
>  	u64 dpa;
>  } mock_poison_list[MOCK_INJECT_TEST_MAX];
>  
> +static struct cxl_mbox_poison_out
> +*cxl_get_injected_po(struct cxl_dev_state *cxlds, u64 offset, u64 length)
> +{
> +	struct cxl_mbox_poison_out *po;
> +	int nr_records = 0;
> +	u64 dpa;
> +
> +	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
> +	if (!po)
> +		return NULL;

I do not see where this is freed.

> +
> +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> +		if (mock_poison_list[i].cxlds != cxlds)
> +			continue;
> +		if (mock_poison_list[i].dpa < offset ||
> +		    mock_poison_list[i].dpa > offset + length - 1)
> +			continue;
> +
> +		dpa = mock_poison_list[i].dpa + CXL_POISON_SOURCE_INJECTED;
> +		po->record[nr_records].address = cpu_to_le64(dpa);
> +		po->record[nr_records].length = cpu_to_le32(1);
> +		nr_records++;
> +		if (nr_records == MOCK_INJECT_DEV_MAX)
> +			break;
> +	}
> +
> +	/* Always return count, even when zero */
> +	po->count = cpu_to_le16(nr_records);
> +
> +	return po;
> +}
> +
>  static int mock_get_poison(struct cxl_dev_state *cxlds,
>  			   struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_mbox_poison_in *pi = cmd->payload_in;
> +	struct cxl_mbox_poison_out *po;
> +	u64 offset = le64_to_cpu(pi->offset);
> +	u64 length = le64_to_cpu(pi->length);
> +	int nr_records;
>  
> -	/* Mock one poison record at pi.offset for 64 bytes */
> -	struct {
> -		struct cxl_mbox_poison_out po;
> -		struct cxl_poison_record record;
> -	} __packed mock_plist = {
> -		.po = {
> -			.count = cpu_to_le16(1),
> -		},
> -		.record = {
> -			.length = cpu_to_le32(1),
> -			.address = cpu_to_le64(le64_to_cpu(pi->offset) +
> -					       CXL_POISON_SOURCE_INJECTED),
> -		},
> -	};
> +	po = cxl_get_injected_po(cxlds, offset, length);
> +	nr_records = le16_to_cpu(po->count);

This needs to check for NULL @po before use.

> +	memcpy(cmd->payload_out, po, struct_size(po, record, nr_records));
> +	cmd->size_out = struct_size(po, record, nr_records);

Looks like the kfree wants to be here. I was going to say just make @po
a static allocation, but I see that you make this dynamically sized in a
later patch. I can fix this up on applying.
