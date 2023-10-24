Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E105E3D3B9
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYQD+gw8"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CAB10CC
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 16:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698188489; x=1729724489;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=3MUE3UIzOOGOuulKH6Xd4xwswf/R+zB+MdD1I3h90G4=;
  b=QYQD+gw8R2z/z907ay/QMkrm0lgqscTL5CnOrYhyS0CxqBACs3Xjelom
   wK0HiXL8ywdeQTPlUytka804ir/sOB/l6rVfmuEruGvN71jphCYJ5XMbY
   K0ht2lzjqoNFpZyN1zyLFQgdBadYbzYb+bgWB/pjykJs99oHGVomQZXgn
   epLujNvyz2qnktyJoVJ2he8wyQgchr1uzQlt/sGVyS6uZW2RbnGyUQPQ6
   910/fIx/5jM2Ad0+Qc0WipOWUYv4GtMMYyHIG6J3K8H/5K8JAhPAxJaI9
   HCyqOMD1fYbxSFOTczyeA/g+aTgWrPxIgM4IOe3PXVyXPERrvrQ5u7xqG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="384403610"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="384403610"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 16:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="793673464"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="793673464"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 16:01:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 16:01:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 16:01:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 16:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvhBpvUcC5AUjV9JZ7LOeSd5c4UY6GW71FpJF9d+6UsgEKlHaYxUZfMhW95PYEuvaHOWU6PAbrfJ4Bc8PPsC2rgRSTBzg+V8OOd3DKSc4imcZPyUNYBQJFonJuLvAk3zY3bHlgSMnxxKdp3VTNHOg5suqTdCaBOVPmhXQwrvIG/lA1CiF9ins2b69IMYTOS/W+EzJkdJu9OkAaIMXNWYTx/ZA/hrRLiuZx8p544yV+4/SCI1PlMzf33RWVjQ8LAYhOyq2izepz4ORMdqTszTeTOUGcJJOcxswbIlTJR0kKqzDQVJ9muvlYTHIEzVX1KN7ZlKgBn6JgYvKxO+U/ZbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNv7ITnOsJpJuOuImaNKFjCN/KAgigZ2+447nBLd3tQ=;
 b=He3mo+YGsIkL55bi+8pJziAd2xW3ByAUqm5nBGtV7pILz7vPQq1RNk15J836uv3sOljsuC4+Zq8mDn40Xu7KwQHKwXB14c/ZLBxUoRNrbdT3G+V0Q3VmXBIcoWGb7eRDz15OJyeoV86ivhiycPGpzA2UHP7rG+xAiuMo1j9fSW5vnuhbiExTn2ij5R8hQyJk2/CZr3DKnZPILwCnXs1O6EiSpEsSjJPij+4KgvJOyooK3Z2i779R1GD8JAO7FarjasJbl28kqaZAwDjdb/cYQtiqbCBMiQoBhlWJcx5RF/SjQ9vO8YEo8mZ9pqzZEPl1ItFGSp921Fl7PfQ/6TZv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6751.namprd11.prod.outlook.com (2603:10b6:806:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 23:01:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 23:01:22 +0000
Date: Tue, 24 Oct 2023 16:01:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jim Harris <jim.harris@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: RE: [PATCH v2] cxl/region: don't try to cleanup after
 cxl_region_setup_targets() fails
Message-ID: <65384cbf52621_1ce4592949@dwillia2-xfh.jf.intel.com.notmuch>
References: <169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
 <CGME20231011145132uscas1p13e9fb6dadfa3d5b61fc410449122a013@uscas1p1.samsung.com>
 <169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in>
X-ClientProxiedBy: MW4PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:303:dc::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4aa752-d89c-46a7-191e-08dbd4e523e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0w1Sq3ixVgQ/c5ftpb9aqzPRM03nLXYvc5V4/Xd8DRUMcO2+DSTBfWU/vnBALjE6VhpEYpe2B5KqM9IM5lkJJQnTu0aJPqgRin9BE35jGwxgkU0Jjj7EtDaOoarZfCPmII9aAog9MzOL7Qoa7ETsHZeN2LIFmC9r8bc313S78yg0KOknTPdzq4BSg79TZpTukzH/g3y19L0iRTL6OfMllOZkasHvCfq7dHluC/IvvUwMuiHNEKStr4XU1g3D5VBQU2x9+ECCJoeOQx0NRmAKwpKbQfdlKweaa6sxfVd7Y9Kkqszk11a+aw/S16VjPEdV4KWe6A3QTbeN5rTCMQA6En3SBJziPUZN/MS5KW4tnfGNHo6Jln9ASoJq2JZir2jCe52GvmC6YmRvZojWsRQCQxgrKsoWZ3MIKl9m0dMbbhzQoUmzBpBjMX75YQOo74TVUFzUTHbni6b3joYZWjJRuymss+6z+cau0vI2hJrak42bJYPhhIU91HfmA0l+V/UrVM2536B4uUoPPuR5ZfZvrCdHFv7scihIGsYK3LVVN0y5OURiPjqMy9SBXS5kmX3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(38100700002)(66556008)(66476007)(316002)(6506007)(110136005)(82960400001)(478600001)(9686003)(6486002)(6666004)(83380400001)(6512007)(5660300002)(41300700001)(86362001)(8676002)(8936002)(66946007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Ub2RALuUctArEjVFkW7s9BFeWSDFXVjkEIuYdx71M+1yuoPtbeuBc9boqA6?=
 =?us-ascii?Q?pR9eLYz5uFPHwqdLDrNMQgyVbO49helwuTXHupwd26b4XO8Pi0WhE5XFHzwn?=
 =?us-ascii?Q?7iFbAEUYlrD95uRZQnyDNCiNiHWYGIXmUsR1yfuq5PWJXN+eSqRSVYOAaB2y?=
 =?us-ascii?Q?oj3ND5FCwNGMOKeYI02g+EdhyS9g8fCtUgEsDDo2/QRHIsBpWuh1+XxsUf1m?=
 =?us-ascii?Q?uSYEu36OrgIqpahgdjqZqT//fSeXF1CiI49t7wIpCJDFqX1U3J2CSJ4Jiqpl?=
 =?us-ascii?Q?VaTbske7jyraGPhGj8YvLVexrhQrgQMIl9hQZ6wE1Xm3cMbUv9482UoWuU1D?=
 =?us-ascii?Q?jkjAsaORJk+BBIV+HW9vFvc0IvSLSntkRzPEAcrmnd4ArmDCrd/QB9gYvmOX?=
 =?us-ascii?Q?gjyJm1kYVfxoivQ2kMnn6daMy4NrIKkOXaY8MinBd5OpUCw5cS8rUO895Ykc?=
 =?us-ascii?Q?sBSbenIGCmfQghC0nflKveieFZPq5nBHdrvGb0/J9ThZId6PScVvyvi9IVoY?=
 =?us-ascii?Q?mtwN9GlzexrgYVwmfoS1jVJlD1dixh/GGUIqT3XX7ApYIsXBZcgzGkhOIB1n?=
 =?us-ascii?Q?ZINzzXXbO9DSPF9y5q6j2WwmByPsS7reoCu/pGRoxlNqICNbrDQr6ITJcJK7?=
 =?us-ascii?Q?frqv5e6YibpKYs/qB+r/3HAWsmm54LWkwwgDJWYSNkORj6gwaoBatojM1qnH?=
 =?us-ascii?Q?zaYJ8ZxJW2kxraBasX8/Iz58CAW1qSPEVqIszh/TxEFMC704PszY4e0mKd3c?=
 =?us-ascii?Q?5YqNjmTDq/3TCWUjkZ9pVdZZ61KFGZXMLTpQarHuhFX1VBgf9i6aD1OtV0dV?=
 =?us-ascii?Q?HFIKINg4k5DvnRyLRzczDYqKp/7cyh07LLhgITyQrPLOQPjTag34AZH5RGon?=
 =?us-ascii?Q?tqScYOM7GNcJgPHFiM3Ry/R3j3WTpeCY+3uEGXl6SK2WUvBxVKZqeRJJSLm+?=
 =?us-ascii?Q?AjJzGCDkWtYIrtUyFooJcipWFIfOYo8gQxXZ0RbaUrxChM4+xfC1s9h0DF8x?=
 =?us-ascii?Q?LwjfwEqetHtfnTkhX5w+7cSySQTWnvGKrLNdxsuee3JWGee620kQjLs81ngP?=
 =?us-ascii?Q?cvBkYEFzNcUc2IhauoFJRFJ2JQo9Oi5I9EO96vinAPD4Pdyt45bKH8gDMCwr?=
 =?us-ascii?Q?lAqHF+zj3JYAIbft1KHcqNxLlo3Qyf1ceF3zeHUeGt685hdljvvzkaPZy7VI?=
 =?us-ascii?Q?vIKZUno2Wy620w3ZcVt0khinR6tK3i+3UammIRPDIvSPWLXuHWIiEVt+QtxG?=
 =?us-ascii?Q?N3U8N6FcIgsMJNRtUX50XiC3fk3SECweC7M1HMtMnLm2YaqwdFiHfHC2eHkO?=
 =?us-ascii?Q?CH9AYe2ZobEH+dSkhWJ6oUt+vggLV/+LNpRFdze5sbmvIWXCPOOWyWhQeFs+?=
 =?us-ascii?Q?NYgaiUQ/n8Ox26ZTnEUWZqG1s+XYSXL0tOrHDU+UVRB9ayFlME+KLz4NJhgo?=
 =?us-ascii?Q?ximllY4wyYqb52qfBZgNn+tnr5T4803giMKMvOOx9KvXQ1g1qLLWZlot5mmi?=
 =?us-ascii?Q?f9vfoLnFTFxOwyJJBfkr/JKWTqIBiKEtOVWS1HqRKdEu6bpQw2KpZFqot9YQ?=
 =?us-ascii?Q?TGTnk/G4ZWNrKLyRR7B7x8R2bZSdgVIQmYkDicMiYqcz5lx/DBbTxfshUG49?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4aa752-d89c-46a7-191e-08dbd4e523e2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 23:01:21.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FQzozYEEO0nw/hNbhpXiPOXJPvFjOxBhlOwZ0FlE8ZMyEH0RazHNY0Q9qgnnUO4ezekl5GDPOpBQsux5+xWK6nHazpq5/D6Ja3RPqSEcAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6751
X-OriginatorOrg: intel.com

Jim Harris wrote:
> Patch 5e42bcbc ("cxl/region: decrement ->nr_targets on error in
> cxl_region_attach()") tried to avoid 'eiw' initialization errors when
> ->nr_targets exceeded 16, by just decrementing ->nr_targets when
> cxl_region_setup_targets() failed. Patch 86987c76 ("cxl/region: Cleanup
> target list on attach error") extended that cleanup to also clear
> cxled->pos and p->targets[pos].
> 
> The initialization error was incidentally fixed separately by patch
> 8d4285425 ("cxl/region: Fix port setup uninitialized variable warnings")
> which was merged a few days after 5e42bcbc.

Patch looks good, but I did reflow the above paragraphs to have commit
references per checkpatch expectations. I believe it did not flag them
for you as it did not recognize "Patch <SHA>" as referring to a commit:

    Commit 5e42bcbc3fef ("cxl/region: decrement ->nr_targets on error in
    cxl_region_attach()") tried to avoid 'eiw' initialization errors when
    ->nr_targets exceeded 16, by just decrementing ->nr_targets when
    cxl_region_setup_targets() failed.
    
    Commit 86987c766276 ("cxl/region: Cleanup target list on attach error")
    extended that cleanup to also clear cxled->pos and p->targets[pos]. The
    initialization error was incidentally fixed separately by: 
    Commit 8d4285425714 ("cxl/region: Fix port setup uninitialized variable
    warnings") which was merged a few days after 5e42bcbc3fef.

I also went ahead and added:

    Fixes: 5e42bcbc3fef ("cxl/region: decrement ->nr_targets on error in cxl_region_attach()")
    Cc: <stable@vger.kernel.org>

Otherwise, good find, thanks Jim!
