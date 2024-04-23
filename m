Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96C19478
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713846224; cv=fail; b=tJRXHp0AFdH/DQau0a22uXOr84Orf2Kb/Hfjs51b97JA6H+n9AHGDViKuKeOClj/eW0zeBVyaHcdvdaRQR8zQnHXdVtgsk7bUZGrwWxljL2QOo4MTXDct7Ba/MR0rr3GQnva2HgoYszSEwCZL8B/qJY4Enh316AKzY5Pfa7tGog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713846224; c=relaxed/simple;
	bh=ViVZTCnTYYs6ebz5ZaJSi1QX/Ajx3rx8Ove8pLJRnlE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E5n2KurTGs7pRKHev8P2pDHNfxzSQW0GGVi25dQrASlWibzZO1/fRHpYIpzpU5csWHhyM52SSSaOT6NQXeNo3U78ZVLKKBVAAIjaIAL6+l1Gyf00VnB90ei71MU+46jgP/zqCxy7dGTV4MsTHEnyYIBKo7qFHyTKQMB16AOk5M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NG6EauCQ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NG6EauCQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713846223; x=1745382223;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ViVZTCnTYYs6ebz5ZaJSi1QX/Ajx3rx8Ove8pLJRnlE=;
  b=NG6EauCQM3xiT8zb0hrRUuTkRlmqFNm9680khL/sUI2L6C5K1t9nEOsy
   oUn6FhFQLEvzMN0kpDChU8pcePpJwsil1zCHEbe7oBwsm6OmhoEDTDXpn
   4JWa0gyfDqzsX2C8h8i/H898YhYXMX395fGkhzreDzNHr4YlCEz4R+FGy
   vSWyMIErErE/SujUaPdTDB/UZ3dgyFKYo0dxZ3lR/L5Ns89FLnqQfK+Lj
   BnZmUx4qTQ/SUSa21Bo4hj23xdpmdXxZRbbabqowTdvzM6HXIoH8Lb0OW
   pitSXQsGPszKk/wcJ/0Q6JhIxhCt9vNhXOWS+jI8stcsvC5DwBlRmsDiR
   A==;
X-CSE-ConnectionGUID: SXJ9irHtTpm+evcu/jePBA==
X-CSE-MsgGUID: YyjYH6CNRgqsWOGiSFw5KA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9282387"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9282387"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 21:23:42 -0700
X-CSE-ConnectionGUID: L7QcIZd2S/OUr4qzkw9ErA==
X-CSE-MsgGUID: bBb1duJ/SOaADPxb7owrzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24103248"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 21:23:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 21:23:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 21:23:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 21:23:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeZSaP0yR6XrrkiqzPczflkfA1FftAi1Qu08yTMTe3TtiK7kWjmuYczrkfoyOaEqjb0X14HrNcR7LQXO4Pp3e0r5bW4INsZFJMzlv+MnKjHsycWAeniRk2lKP7Wb1GPpGXjUKZ/8FASDSeLUEQdZU/YJ/HcHRrS3cHVLLEpW0AGCu615CalJwOsfblHFQguaHiVmxkLAJjCLe2UFPAW43uUM2yaFihxX6w+g/clTjyWhjTVtzvpZZGTvQTae/xcvHkz+TZDe2pGKwyEzcsHDMobmg1sd6Jw95iVbrYMJIGR8CNZCDwOCGjO+kDtwMtLhQ9FJivW0lzuQILvO0g72LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yucss1F6H43INM8C68VCSNQz53u1gySiueZ2dM6sWs4=;
 b=oC+lNRqq+rZEbIFlh6OpxKsgeWezmNyXNQO+VHlGXCZ4GFxtynyjspkV3KUF8naKJTDKc5fv5l5+jvwyFzJzbc1APY7hMsOtXpj4q2lJ+hnRicZpgrxIDRLZeU08DgURwMFNshPGSaYSTQj+IAX0UObScFh0NiPEWG4nkvuv4RhSRDWCBb2+aAUI8fDpPBmgSdopI0R+ZYYfXL4dDJi+u/aX/LdHOlVIlRG2ODLbIPh5vus59mI2v/LA3502Ay6blEzzAGjicnxOT/tU6vo4vJmR50DvJQ0iysz7xJBlEAKgqWhttD7kmih2jL05Y1Tdei6gWIy3b/njqPDtP2FBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 04:23:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 04:23:34 +0000
Date: Mon, 22 Apr 2024 21:23:32 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <662737c4b3e7_bd77929478@iweiny-mobl.notmuch>
References: <cover.1713842838.git.alison.schofield@intel.com>
 <800328a3fdffa0f3ece709be337bd64a07089bff.1713842838.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <800328a3fdffa0f3ece709be337bd64a07089bff.1713842838.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4089e7-5197-4c54-8845-08dc634d23de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KT3t9DPSc8GAU5SpcWwojsDpROp4HF4zBoANZ7WS9EdHlVU4kA5JQKjwHZbn?=
 =?us-ascii?Q?B0DlnfBEGEGuF/NYeNZMivqsIWsEJsAgC/OhT/zn4W6OaFobkEzhW2bFzh+R?=
 =?us-ascii?Q?Y1f6cvso4hQhTDLfN8bcW9TiYlb+dDPJTpvSG+EM4E1DrK8DarlXn2txnecZ?=
 =?us-ascii?Q?qli++UlazbadBovxDYrWItOU+LG9MY1nOcDoVyZA795gKAHSdEVTzdJNzE2Q?=
 =?us-ascii?Q?Kc605bWaH/ovVqXOzhdAFTvnstpGfo5GX7M1rfN/HykmGnGI2rp73Tu4g2MP?=
 =?us-ascii?Q?NLEzwGAgDtUdi/tKXKAiw0EUPHTYBggNATYXtND0QwQWVMO40YZGNbv/F+cI?=
 =?us-ascii?Q?QPwOEzAZg2a5Rn871AdvovrLht1wkooOz9yhRRN/E3XTsOw5S89VO9bhvthC?=
 =?us-ascii?Q?KDi1wN4vSge4yoBuFDsm/xYjXWeemlIBBBr/4chsDnj6axkJdyfSMdaGASyT?=
 =?us-ascii?Q?8I8L0jcrz206wfl8njCSJt6yQseHnsSnrY3PY09suV3AH1GI8oMti9Adf6J+?=
 =?us-ascii?Q?WnX7R3/XHAQEOF4khLsar6SEiOBgM8KBQjvFDsSC/O/QUUaviJynYgXkho0H?=
 =?us-ascii?Q?wQuTf358+kLjALKC7QEek/fFx7f1szsS8Jg50OuFAIm/hGVmB5vgXfsefbk0?=
 =?us-ascii?Q?OfvTICAoowbg0R6SsiiNJwbC14cXuyN0vkxc5UqaPAOaeskLjcMEIeRb0nCf?=
 =?us-ascii?Q?6DIomxy9JdSyf/BpXlp5EC0CFLIbNyqqQK0AvQShIxIsUfxuZIbJy4d0YjGZ?=
 =?us-ascii?Q?+xLrHU9t/pStX2wOvx0XM7bIu/sdHOpr6VavV9VJ/Kn7Fl+1X5MVEBhOcIfi?=
 =?us-ascii?Q?qZFpGwGiQeYo7kozlyObeRpWuK71QnZ/UnhAFOmCQs1t21JmxeX+KB/lj3Jg?=
 =?us-ascii?Q?2ZAPk1u/ZFjnX1JAjp4zJug63LWExNEJFrGGVPFkuTwUsJtQZwXjrgzb/LRR?=
 =?us-ascii?Q?jLo0HH+DGq4FGM6HfFycUzKRb2iF5c55+hbImr5nAdUrIauyRfO8IYS4Kara?=
 =?us-ascii?Q?kRNYidd4G3WE4CVnTy885v/N50t6qQpMpUg4QQG6mj8RE06zaGKE+umC7xR8?=
 =?us-ascii?Q?oL7IQudkm/QlVlyCts0KjyxV8i3BvZZRDJiiSBkMBxgP4MSbBlyJDaD3u/Tl?=
 =?us-ascii?Q?FLIQsjd1p2TkrBlfdatSqVtZ8+5LQw2O8PkGQHhBHW6pL+E6K70wnth2hYjI?=
 =?us-ascii?Q?AmDQ6qV1wLsmPvqZlZaNx9XmsfBkGMYEk2R8PvwJ6xX+gCD7mTltbSIjtV6A?=
 =?us-ascii?Q?cUi0eYCbELwBMLMR4zsNR4Dd69nyg/kfPHgU5mNt9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vQw408TmZmRDvpDXoyEIK41lIfab28nyWJ5wuwSR3/twnNnQvTDNMN0+OVLZ?=
 =?us-ascii?Q?X5bPqP340oGxzX1UZTLyfEQMuI0HcZWm6Q6COaE5XofeJG65tKb2xXCJvJcw?=
 =?us-ascii?Q?cVKf1wlFINNyQUFEeyimHneyyKIaqeQWnoacBEB2STxioP2fWPnPUxLH1n5x?=
 =?us-ascii?Q?8jHEUpaRlY549lylQLbx4TEJbF3qnla/RlQ0c8LocWRxf4zJTkElZfImInzS?=
 =?us-ascii?Q?E/BEf9YAEIqNGdZwCxKllLSAB41PT7maV4SX3o8r17wr0gYe3u23n4FlhtRi?=
 =?us-ascii?Q?aGtWstZVOaMi0JuxxCL4wqB0dEGZSItQs5KRFWqRotjzrLv5H9B1DhpjXaIz?=
 =?us-ascii?Q?Hz7iD9UVPQDXDoq+9rB7xikP1QsAp5UOGELvx/DfrZ8XP+HETcdBvjlyCUfN?=
 =?us-ascii?Q?5fyF1aPqs9dbPc1scGWoC3nHHVT+Cn87Kw8PrBFUcRi+PA3Jy2ZCRhpax+sk?=
 =?us-ascii?Q?SdJJnZcot3nWxYdGtpjxqpAk8SVEgEj1uA//uePKGOuUkNlnBqQl7YhNR5UM?=
 =?us-ascii?Q?soh1eTiOo581ojK8nUYEdSnWZY4ZaPmW4byvuGmspO4TcKf4Qp3VcPvU/svY?=
 =?us-ascii?Q?ptN8hn+iSdBKsTvx/6EPW07ujtU+nxmW4R9mQL3aGZXYp6ov5Js1qBGzeFYx?=
 =?us-ascii?Q?IY/0gFSEtUad2/4LDNIa3NsFkvKvyWi7dt63/3HwmrelnjVLPEazO6TdZHpe?=
 =?us-ascii?Q?9f/gvcXbLOcnvai3MHxqAjpzt0CXBmgrHt7+NxHr7SsZkwg/uybAnLIEqHHB?=
 =?us-ascii?Q?+3YuMCR+UqNVmsE5G2zblZoa8dXcTcLnP8d5o0i5hUnOAOwMVyduhulge6Ly?=
 =?us-ascii?Q?DT+mgXlE84F6Y83hAgw1Ld3tOM8nlHAD9EYjMzh32Hplm+L3bsNbF939Ua2D?=
 =?us-ascii?Q?oke0Skv63148lG0+NW+MByrsFPCIBEalh1EPjC7XSxbbIoW9Xe/ayZdBAvT+?=
 =?us-ascii?Q?swbl9/R7cI79jNqv/7vP6rqzroikEovJvs8ya7i+bpzlulbGIRPHewZgwXfO?=
 =?us-ascii?Q?QZD/oGnaW6wjYLgWTyNLvUhUae8sPU0rguOgYGmjmpxpmgefj/yPT4kJ2Lbl?=
 =?us-ascii?Q?C7tGrHCIYjnOfcX2LvLw8fkkxJ83d1OKzjYqMi6wlJtQ+AmGa11xowqYgX6v?=
 =?us-ascii?Q?IYwbkXvjRDVJ2dSGbP6pSbNL4viS8qjaUD6HujXDJLuub25tT6aSv3i/JWun?=
 =?us-ascii?Q?0qkgP4G8p+vrsWdFPfe/Xaz6FzAn2u9HzJI11r/9fv6FGT3Y/JMInfOJVE9t?=
 =?us-ascii?Q?d+d1bikMYaMKnW1nEacc0iOk9DRWhbLf0Ew6PIxgKfGuUmKwxj6OUFYOKfuQ?=
 =?us-ascii?Q?/zj6U9y3ijZmKfo6Cpu53GixmMYjUz+ZPSrV3BzEDtAFqL2fWOk+nZPvONoC?=
 =?us-ascii?Q?Mu7CNLSayS2jzBjCxxWTl+3jTy/5wVh6ak0LjC176Vk2gscSgEuo9hFqzAP1?=
 =?us-ascii?Q?B1Z+U/ZAAOZBsqd2qWXQNsv/QjjwmKLtZTX4AL2yQmyIbr1vC5P/6A3gAGPC?=
 =?us-ascii?Q?i7QqQIRMjMrV5LHHwnpHtLbDxzbhh774L4FPo55OjjJwwVhMgBoWBJhAPw3O?=
 =?us-ascii?Q?2lZF25XBAZ0s42/cxd3zayUZMBLvEHZmrdqjCy4l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4089e7-5197-4c54-8845-08dc634d23de
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 04:23:34.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeIywk4IQtNri7c1b0E5nPOOqxdbrKgupKcP4mIarAnuAB+EGsfPOOY38UdEjUTiV6ATZnTX0+ZtTw8vc3s5RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5952
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 

[snip]

> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 161bdb5734b0..2e24364b2b8d 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -14,6 +14,28 @@
>  #include <cxlmem.h>
>  #include "core.h"
>  
> +#ifndef __CXL_EVENTS_DECLARE_ONCE_ONLY
> +#define __CXL_EVENTS_DECLARE_ONCE_ONLY
> +static inline
> +void store_region_info(const struct cxl_memdev *cxlmd, u64 dpa, uuid_t *uuid,
> +		       u64 *hpa)
> +{
> +	struct cxl_region *cxlr;
> +
> +	cxlr = cxl_dpa_to_region(cxlmd, dpa);

This would normally be:  (somewhat nitty though...)

	if (!cxlr) {
		uuid_copy(uuid, &uuid_null);
		*hpa = ULLONG_MAX;
		return;
	}

	uuid_copy(uuid, &cxlr->params.uuid);
	*hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
}

But in this context I don't think it is critical.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>


[snip]
