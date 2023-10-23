Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279B1859
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HH+wWFIh"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A20D10CF
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698098297; x=1729634297;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4uy9RuhAIooiwpVrw/BT7ax5/maJJ57r0gkHW5NLt8M=;
  b=HH+wWFIh8hkUPu5qPsTTcsNhb6oQ/n6jz2LtRySxBsGnUzXzw5Qrl9Us
   E9NozYmu2KOSk5l1GxZVWJCXYy25/oSZgoT0FuSq8W9REfqayU/rE49xG
   K4xs1X8ZqS+6Nk8PY3XZuRIKHsk9nPlNl07DsHcmGkDkZXS4S4NAj9hau
   dFIErHvjJr8cw+USgAqjrIMqpxLmid3t2bCYNDbnzeCfdIhHGTScq/DlE
   UXGVrHG31a3DbRHgiBo8/kNVQEIS06EW1tK45y49wuVEzQiXE42RtQUOR
   1qTb9WMxb1yKe2X/hujHH/HLqWNvOdbWK5fvhbqHjaGgjRSOcg344UFhb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="389783656"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="389783656"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 14:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="848898335"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="848898335"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 14:58:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 14:58:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 14:58:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 14:58:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 14:58:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5p37YqbHhdMqsLQ26A1gL9lop3qThq5wS1Md7yOshXdpO0Q4QLLns87UwU8NtCwtJHXkHVMFbgG4/mGLxCXHZvDhvm0d4OD86wyQDoWaqBvoJFxfs90xw/TIJXakza3PbqWB1GsCnyC0IU5wkpPXQLbeuwBv99Y5rJSGuDWTWeqH6YYeKmxnXNzfr6ImBmoL0OMJGTgU2yBXiCq434M+TgPikxOcJcKmbKXtqwJ+U7waQqKtNlylJTEyc5sk5NF6iUpgQ/nEqNaMobAmL2dUPWaC4f5ksIpfWhlqaW5s3TBeffCdk+niatO8OuzvLrkABtn2O3C4FkmMjbQCYUTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om9WfdNmPme4vgnPdBwxOhxGVx7S5AEsdLUzr3sNofc=;
 b=boy39pfCin0PUKTCNxFa7CsncxJtTtPmDgFqWzSY2Plh7w1oPuWvzioYAcVaVbRqnNgQLMizSuObY7d38g0vPP7FBpYTRDORtrG4pxkbOwo+avxErc0T8EITVHRSpWpVNUX3jh7fbH+ZL8V5VpF7dpy6a4w5N5A/jlno/EDE00rXPNxd6iYLdf+yXkhGHhS5X6eTvVXVMMRvUqqxMrnyeGekDItLNNZMh3HNzQlAumFurBdjC8T56E54CE6R+TP3MUvVfQZdG4VZJVBfeTege+nmvtxby0WMMd9IOG81qdnWwyT7XDg2PfT7A4OCUB8nUCPKOm788oNax1F2H3vI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 21:58:11 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::8dbc:889d:7f9a:e7a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::8dbc:889d:7f9a:e7a5%5]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 21:58:10 +0000
Date: Mon, 23 Oct 2023 14:58:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: RE: [PATCH v2 3/3] cxl/region: Use calc_interleave_pos() with
 autodiscovered regions
Message-ID: <6536ec70bc34_7258329498@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1697433770.git.alison.schofield@intel.com>
 <533d9fe49c10d7cb878ea9157232aaa5bb657ae0.1697433770.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <533d9fe49c10d7cb878ea9157232aaa5bb657ae0.1697433770.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ0PR11MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c21d4bf-6e9f-4206-552c-08dbd41325cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ml/BNPIvj8HuWgLRdrd1Glt/0YsMgVww3qhxPbiD9zcuzu4gqUT1piClbDDvS779QCUYWcR79bsBao1srvrTwOEh5rH6sIgIITHcZ5CqOkFtWWusu3cBTYPKYEVpcPUxJPXHwA0ebOrEMcr0s5bEHxByuiMKc3KMb6hxa30v1YnoU/MJTCg3FVC2/7+JzX0xSDMpxHORnao/tO5Kb/QLTUjbnBPxLdbhyHoU9R5Ka+HOtzZ4xoGoD7hqyQdcQgkTTYYwm7FT0T3/4hTowoZx6sltTvgZZc9JiX/bm5FogprsZn4PmAybu5uamqxSIZFrcjMZ38lshuRpLaa8F97T7FOHUUTKpkaD6A7TZKQnOaRwwHWh/zXRkY7mx9wNSv37MQACPTxQg8ie0+KdZUzTnX5LxxKC3CoOJnXYRa5m8SjCyHxyEcwWKXUmTmuly3hHQ+epQEjk9vCr1wLwWOORWY3OQmegxxbVNjahYTvbUcRiZf4jn5/4pvH/v/oxnZwJOR6TaroXGjtyBSu9+VNmxv/+j/Hauj5And67fyZcLEYDLUs/78SE1Yx3qSbc+f79
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(107886003)(26005)(82960400001)(83380400001)(6506007)(9686003)(6512007)(38100700002)(86362001)(2906002)(110136005)(6486002)(478600001)(8936002)(8676002)(4326008)(41300700001)(316002)(66556008)(66946007)(66476007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iQBAJg7SOkc1GOeO4j+vc3eGyXXLXOuqSOC40stcn+wtT90sSLV+a2zTavFN?=
 =?us-ascii?Q?Sv768gJxevINTIHqYWJ9tw79fGdZPIwDutVRoAFAnuP10shuXtHXjhzDfOH9?=
 =?us-ascii?Q?Z0GTg8SJOTJ13v4V0BqWsje7NIST2MVlL2Y5vsJ8aCJD4W+pQc6H5r3WvIcB?=
 =?us-ascii?Q?9a7Zby2HMpKWnZ7fwzaV7oI1ybWCYpXZoF1B66/EigXGouygw7q0aI2rnPkN?=
 =?us-ascii?Q?ibZ5OOj/rqdzR2+ZRNKsmmHGN5ivt3Zm+26Up8iHLw4ZLqIMOxFtMCxSIdUq?=
 =?us-ascii?Q?JtfRucSXKLLVK7LDQKyI45yVxPARj7fWAYzmVtYR6BYd4HEV8EvY5XbjVPV4?=
 =?us-ascii?Q?P1Fsd3P98DLz3/llAG58d7Cpo+4Ol8/1rIVQRrc7qOb7gZDTPpkxYAwG/F68?=
 =?us-ascii?Q?23PTnyz8guv0a5aLpugimdgqYJY7J13sNAPOM4CEXypvYU6iuv1kVwSiCE8t?=
 =?us-ascii?Q?wPbna4NRaRvteUg4IWrqYHzMo7L0mVPu4uNTSINZJQa/+uQTvhMKGNR+SKXZ?=
 =?us-ascii?Q?aFw1EZN+gBNZaV+mD8S9YPXVxmIvgk6llRJ6l1YbD5ZlQmg37e3/sqlwO6jq?=
 =?us-ascii?Q?CIjtLEkPb+xGiEqj8pUEnFNpCt6QdYpRnU1+k4dwmv4GWO6r/hjSbRswsPIA?=
 =?us-ascii?Q?qelyMMQbxJa5klbR89Ia5cRudp94HKWEDZ/x5BJbhaivtZwN5tY85/4FqsXk?=
 =?us-ascii?Q?cgWfA9KvU2Lod3sQFKqZKmWx9h4v3Xg8CLsezW3aa20RQxV/a8nQm1bmEypz?=
 =?us-ascii?Q?z4nBM6X6Ne/+YIxs5gDYnGwxsTmuJl9XbLBenb+kvi+DkN2fGbuDDgfmxYKo?=
 =?us-ascii?Q?Qt24pcV06r7gtbO4PjKPVFMY29wpU+zS95VMFlOIegPTWzKVzMK8VM0sj6mC?=
 =?us-ascii?Q?S9IGL7FjY3k1/qAljBVT+THAm3mlYKobpj8i5P1YFlQhqDxXX67jgfhzshm3?=
 =?us-ascii?Q?XJOVvfxMVtw7lDgV2zmYYh9hecI0BcZ8II0ctmH08SWZ/pT+nn14cpLYRu1Z?=
 =?us-ascii?Q?f1pOz8zFXcUB4A6R0KwrnCXYvrn4vsQ+MinFSLMoGK2XBxYfEuVJnauhZlAW?=
 =?us-ascii?Q?OhaRSrmNMvcnHqJ1WJlNDF45OEjWR3pxF+8TQR4LA8CirdcOp9WeaiRACpbL?=
 =?us-ascii?Q?fAFMKUth50RPQMqEP+lHCTiwXFt8SUAJGA/JlNEaGGenc8r2fXzIuYoE+yBx?=
 =?us-ascii?Q?7ri5lXJ8nVArpe6nD3ZCsqov7B2hcbIFTr71NaQZa3DRq6zfrqHzSS5OVhHI?=
 =?us-ascii?Q?vlshclwvw3RqWiGZwZDKQ3bX9SMhoFuy1EjRB2up1mnpWvSO/6qstAht2tlJ?=
 =?us-ascii?Q?0RNiEtTIhiTKADBRAccMHNtcEwzQ4oeAuJSN99cHNu7onKsMhiXCzf/JPElq?=
 =?us-ascii?Q?UuDDJ+kgQEQu18/nnNWCju+xsynQuaF4fl7ROphtck9W9N80lfNrwivEWfg9?=
 =?us-ascii?Q?659n3Zw1D05AYRote7+0Hl6/0/2MKTjj8InaPWmr01c2yZYI2maRmjwSRNzv?=
 =?us-ascii?Q?KDQM9OmfwHh+7ryAxGbMkQo2eamjDX5hoB3hY9f2muZziZWHUoLHf8bStPj6?=
 =?us-ascii?Q?hHymaVTYIhcLcni6kdJbZ8jCelwJo7xr0Vt6ZQjutj0jFlr7XB9fNTfljQHC?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c21d4bf-6e9f-4206-552c-08dbd41325cc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 21:58:10.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZz2bvle2p+3d/pDj+2mquffttcwFVW+ry7M/JDVOA68J3X2MApLENw0jc4xT78+WRP5eGRL8WL78j8uFwW26xkCRAgzmSQLqYmWKrjuegw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> For auto-discovered regions, the driver must assign each target to
> the correct position in the region interleave set.

I would say:

"For auto-discovered regions, the driver must assign each target to
a valid position in the region interleave set, based on the decoder
topology."

...because there are lots of valid configurations that may not be
"correct". I.e. outside of pmem where there are labels to validate the
intended position, label-less autodiscovery can only interpret the
current state of the decode topology.

> 
> cxl_region_sort_targets() uses the kernel sort() function to put the
> targets in relative order.

This can more agressively throw the current implementation under the
bus.

"The current implementation fails to parse valid decode topologies, as
it does not consider the child offset into a parent port. The sort puts
all targets of one port ahead of another port when an interleave was
expected, causing the region assembly to fail."

[..]
> Replace the relative sort, with calc_interleave_pos() on each target
> in the region target list. That will find the exact position for each
> target based on a walk up the ancestral tree from endpoint to root
> decoder.
> 
> calc_interleave_pos() was introduced in a prior patch, so the work
> here is to use in cxl_region_sort_targets().
> 
> Cleanup the obsolete helper functions from the prior sort().

Maybe a comment on the testing this passes, or the plan for keeping this
algorithm regression tested?

> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

[..]

Code looks good.
