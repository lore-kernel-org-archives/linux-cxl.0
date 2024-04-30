Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133391802D8
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517179; cv=fail; b=f5PyOVnpCxwYBr641E+SHQW5DlkGByZQH1pRKPQ2OYeUiohUpACnSphwcBEnQXX0DgnfnqD1M/VipO9AIYg41kEWJ8lfzaI3oHLNG9fi9PVdDDqGlGIBkGeHLF031j8p7H1f6ROAg9JtGJhc0VaZE9DVjIBDIpofSvcnzuwq9JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517179; c=relaxed/simple;
	bh=zRILQqBzeC5k+o9NQ8tk+ZOOHdYnUE0975GFLZFiRTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TPwhudgzHoMVLMUbnBIlV6yXQ3uiUi1lXQkavH73un/KgzpRiecF1r+N7z/Ysit3mYIlGp960Vtt22NWfvgUx2aFRbEl1CBVWUU37jrt6R60h6yLOYWTQjCwG0a28yEB7imdNmBqlK1hG4y588kNxLT0oaJu//GX/82fMK0oQYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByuOnHyK; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByuOnHyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714517177; x=1746053177;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zRILQqBzeC5k+o9NQ8tk+ZOOHdYnUE0975GFLZFiRTc=;
  b=ByuOnHyK+jHN6BqtEI8saTbg05+ApuiJPTBqsr0BW9Y86DhJFyUG/PhL
   o5HmeGpKhbBkM6F7C++SLZmlBJNU2HooTXbGRaAoi8KhkI8AiNkjki3So
   Lpg/XiORIJU/0Xd5RttLUz/xcgVafzOOin/so7yxxlRBAr6pGCs4p7UHf
   OVWeqIt/9Pa3mBcylp0LhHDDee0t+7g3QxI5oalEcqEEbmAWzMENqQYj9
   lM78ofoYCgb5v6AGoC4fA8BgASMIsHhzy19qS5UsLHmd2ivgwY5vHNv0q
   5HWxhcWR3EcGecyIwbhDAOY/SrFhgxnKKkJU2xV/qG1Vbd0SAggID78y9
   g==;
X-CSE-ConnectionGUID: h9OOKVVeQr2PO4N0E42SyQ==
X-CSE-MsgGUID: dfByHXgESRO7lWSEenm2cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10790316"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10790316"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 15:46:16 -0700
X-CSE-ConnectionGUID: 5pqZTE4hSIin9Fh97g8HCg==
X-CSE-MsgGUID: boVrqgdlSPuOKrvgGTg8uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26622408"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 15:46:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 15:46:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 15:46:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 15:46:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 15:46:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIfbGlkkWz6bQZOv5DfDagBdZhA3ftRIQsmnTCs9HLRzbITXoJBdJScw8uDfCtGVHfWKdF/GPdpOq1+3i1lLBxwOv0apvW/km+zlU7/DsDJuuqBZhuLM8jh7d5nAp2Zoz3fuoFDT7WuMcZeOGnhMocdWkaP8IPVgoZZFAOaP20DmAKmVwfJUcncoO3+zZhdrZPQvXsCsyntnD30KUqqfi8n/kd21b6i3RImVVIKd0n021vjqE23MzThZ85q0nxNwq43cuoAro8EMtzaUtFTwgdRBuHo59UnRc6H88LEYhS+2urwr96l8MM66UltOVZkXo4Kv3RURFj1M81CAbUVh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB1eKKTfZsWOJ7d4p34lpX1u5A+6r5DAy82iuAGzWUw=;
 b=QyR2qRlqRMRoIZBG63GRWkFUwnhXore/O6fW4/Lad2Hxe4hs/9FquyCs9GltZ4DCacI21eLgYewbikvlzfomdq9CfCACP60ssjJdTW86LroS4hAhlWo4vtlKnaT14kKEW+ALycg598cOAzVa4Thc1DiY0ugxDJpzX59OWcd8eqqIJQE8IIAwX1bjLury41n009GRoqOULrK0/ZG0qISq07tgPNq2WBQDyjfEE0lVISJgQv5qMini0pIqDez/eLNtPPd2Rd0CmHSSkeAuC+MyON3gBoVvrfI9newwLvkEPB38gzpqFdMopqidYBBsrQZH9o3u4hy4Bzcw0tuairXKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5325.namprd11.prod.outlook.com (2603:10b6:5:390::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 22:46:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 22:46:11 +0000
Date: Tue, 30 Apr 2024 15:46:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/acpi: Cleanup __cxl_parse_cfmws()
Message-ID: <663174b0919f0_10c2129417@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170915213220.2419769.6117155173006983208.stgit@dwillia2-xfh.jf.intel.com>
 <171235474028.2718248.14109646123143505522.stgit@dwillia2-xfh.jf.intel.com>
 <20240422165906.00007005@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422165906.00007005@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:303:8e::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdd1564-8014-4611-afa6-08dc69675508
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ADymTf9fz8hxTucvBgmMIffC+Hp/XdxedtxnzLL36gffkZVI7mxLNHc/uHQ?=
 =?us-ascii?Q?Yd/MRJUexMYrP7m58qx8Rg+GwjmWIThL+qLFnb1x8o9UYI8ngiut6osjuFkb?=
 =?us-ascii?Q?C5GJWs4Be0DzU43y0UX6Dmj+qiTBvPUYZwSNuyFlXbVgTFk9B+rdbW9ya3Z6?=
 =?us-ascii?Q?BvNyJoP5nT9LsjSUB7l7bwowX6ZnH1sEUkBQJnPrGuIPZEy3GPXpO0OerGqG?=
 =?us-ascii?Q?cicg97j8Ph3/X2ouFn3u86yngtJ4df3WtPVHrLK7sfLPlh2+O9UWxtVWUm10?=
 =?us-ascii?Q?dZmL4f6Yjq4mo8PrbnvHCzHYcgqfEL1vnarZb8Mb3a66RpdZGl9c9WqVn959?=
 =?us-ascii?Q?QbgR3TnwzKHV9wwIQ7ZHPQmt7fs/VXyX75jQCYsi6FF7C5Plks8m0A+NGI+k?=
 =?us-ascii?Q?X2JCuSV5BnfUclLmaHh9ebDQghdr7b7siVq6wFvGtux183OBmtSpiWqYCcV6?=
 =?us-ascii?Q?Ano6nCdPAjgkUG1UPlIuEBZmWFze2Ja5sKTzg1+Z4RahCewgtOPHS2QHyZ4M?=
 =?us-ascii?Q?ZpMOhAJUA2mMU1XkIc8LMd+/KGpW4urTpDxegaLyw3bmni7b66MGk0LerFcc?=
 =?us-ascii?Q?vvcNrAXZd5g1qJdf7SyxLn0zkv1vjiXtTYEVO4rBpvMXoSBXAjL0sZ+/xqHy?=
 =?us-ascii?Q?TbjqXA5ftwNU8XgCRBkBzwP4bNLvEKo4Pf3uYBhXt1WGdLmeTsOyOJxI71gU?=
 =?us-ascii?Q?ik5Lojh3REwYdfMc/k+imlRINTs0EqmMNUV/dgRqZzj0HXWcZvFil/faKHvg?=
 =?us-ascii?Q?r4E/qeC8ywyQRK0rMvdOAItVZsK/Z1PDEPwSQEIRt/JxDG04DE/gUDTGQBgg?=
 =?us-ascii?Q?pIWry3hvTBWz9udmxIS4RDSltxqP9w1Knh+5ua2+4NWK3b9pcUFMiyZwuIZw?=
 =?us-ascii?Q?O/lLFFcJ3A0N9aTjwogX6FawqC4KyVQdeYyhv5YI42eiAlLOqMpt81NiWc2S?=
 =?us-ascii?Q?pKEEDYEeZImBOin1ad0gcutMoRtzRnc1pu7A6SXOOwk9MQjs7NzZZQD0iaFr?=
 =?us-ascii?Q?nLaRiaRqmAz70gKgHbN37Fhu1PmFz9JVwubpxv0fkr1hydCoudb4CeiLHJEI?=
 =?us-ascii?Q?wtvDb61B+7XuRCxvk3kXyBh+czs6ZoHXyO2Hfmfg9z0B1pbGKi9yddXQprNg?=
 =?us-ascii?Q?Q9H3shzXqu7u9fFJL/iUsgHGOOZi3IAXi6kdgKDs8MICp1lOL26AuJ7+ijwe?=
 =?us-ascii?Q?mhAuRBpPJ5HCvROGoD0IKrepm2xuUve3qCUiLJAJEZLL2q3zthe+PtKTT5w?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ia+YAlUxL/0UOfFXq0pYfKgUJiqWf4+l9srRPCeLGFCG01FpDkAUqDgAJOne?=
 =?us-ascii?Q?jxiN9XGSjdmK5qe0jW+lFAWPiyiJlgXTtGdQJjHuD0Z/wKdlEb4rzuAkBgkU?=
 =?us-ascii?Q?C9PaffwPZO/QKTHhnZ5ymeETnS28dsHXceN6B/6XcI40maPhR1IIdyoKQOwc?=
 =?us-ascii?Q?74JhoOtCIs2Jf8tv3cZLo6DxZ17t4Z8EJXMoSog+wWccATxSK36+2cbU2Jvz?=
 =?us-ascii?Q?L14aOdb8xPLdyiGrefQoA9WXbmMLeomn9YydjsRM0r+RYbHNF/4LeQyv/tfm?=
 =?us-ascii?Q?ajz2fVf0CBS2GaDY+Co8R13YTNeGPNU72HzNgezyAMTeETMZOIb2qj8PPhu8?=
 =?us-ascii?Q?mGI4YKoZmOhg0S/CznHqbN3gWMa3B/W+aCsDueEmwoIcGLqmJPO/gJo/J56T?=
 =?us-ascii?Q?/C2UACUKcu+VnX0ehBq3YeAgum1uh6e7kUtPzFYouxWH7dxKYrrbaAMC/DOY?=
 =?us-ascii?Q?/qfSf4laiStdSPs7X6cb5UHrxXrwb4HVR4VsqZt/bfPCQqqVe4KcZjV6HIJS?=
 =?us-ascii?Q?Jbq7lscCeSl8XEaVTxCrqQ2HoPThaa5LdtsanQYN7TWQqeF06XMi6lTZIGhF?=
 =?us-ascii?Q?PIL/OEuNPrjatM7jqmPwmsKe/S1/d7u/Phyi9FZEI1Uz+L/QkSbcMP+qe7iR?=
 =?us-ascii?Q?uF3itCNMRtvwsAZZ+w2jBH2QN7/wgT25tgKLMrwkfDxMev+q1BlHipSPWf/3?=
 =?us-ascii?Q?ptGjW6CJuREHdSWFsH4DSr9EOdrOJOAa8guGKbGo7Tsa/HB+aCyhCAiAcOMB?=
 =?us-ascii?Q?Oa68gknt7WlPWxVoSScknac7poRcDEY3EISmUzWiGe2UWR9uLoywEXAd1EeQ?=
 =?us-ascii?Q?ZHw90J2HcMDfXIF3s32kPJIwQ505MRekZ0fCJbqXWlHkkWFm5KQ+xNgzvlpN?=
 =?us-ascii?Q?TYLWc0+Gdy7UqXP1KD//o57zMwUBRkrA665HplJBQxpW4ClXxbZdRDFPFYPW?=
 =?us-ascii?Q?J/eKfEvS1RN5RIeTlo1wUwcbX2/vvqOVkPbuYrRlOpSA5RJiQw79vQKSrfUl?=
 =?us-ascii?Q?3nYfW7sBbHPx5xgZ7FgZBo6ovGGRuJpVQoEIt2YkeFapD8xWP+jW15Ojf7cl?=
 =?us-ascii?Q?/3oXyzmsVaISyFniUMKocfZyG7W8J81nNi2btLHU0hKmPtTAJvLEjIMy5ID/?=
 =?us-ascii?Q?QOuOx51EOAH2robPjMbmVyaCXfe7NmgkKAHZj+ALNoWwrw2JdZVJjevwKkHO?=
 =?us-ascii?Q?RFmapbI+PA0O3QYyjMBRfTY/vueJ80fHcqL8VKfA7vTejsIJOXOH/ho53z9E?=
 =?us-ascii?Q?4u1zhzScQUbKBCu5mGKozjaWHoT5DnOJteaH4JFUwt83a4WNRNHDsmd/5xDf?=
 =?us-ascii?Q?mSkSM8T/TZCCWobJxtyMhjsgYgetEReHFxE7aQ94b7608lHzbs1VzOr2Vbu2?=
 =?us-ascii?Q?yfB/yZuVVmXK/rpuiXasmzN528zEesOS9kE8dCCrETcU2KRay902Sq2U2DXo?=
 =?us-ascii?Q?jaaMqZmxDXMnkA2TNFzv8yqfX6kUwp/nlC9TxNxpeudq1pjJROsbHFpJDb5y?=
 =?us-ascii?Q?oJE2B5s4NtN1+GyO6bi/w+aobMCXwnS0ijvpvLjwXXo3BPYocYrmjTc3oNev?=
 =?us-ascii?Q?Gr9g5f/5ZCXkJlNjsYVTxp+bBmlqiYoJu6/YJiYCVusDhpshnG+SdL5YxPEc?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdd1564-8014-4611-afa6-08dc69675508
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 22:46:11.0360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPLFGTkRobuPWCnwoFk8Trj39OLHoBwPEycwxOJe//5NUBP3pyI8aoLFdXe4F1GTfIIcXylMmAwc32HDdAO1DK0IqAlKnZC31FHk4mQAjRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 05 Apr 2024 15:05:50 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > As a follow on to the recent rework of __cxl_parse_cfmws() to always
> > return errors [1], use cleanup.h helpers to remove goto and other cleanups
> > now that logging is moved to the cxl_parse_cfmws() wrapper.
> > 
> > This ends up adding more code than it deletes, but __cxl_parse_cfmws()
> > itself does get smaller. The takeaway from the cond_no_free_ptr()
> > discussion [2] was to not add new macros to handle the cases where
> > no_free_ptr() is awkward, instead rework the code to have helpers and
> > clearer delineation of responsibility.
> > 
> > Now one might say that  __free(del_cxl_resource) is excessive given it
> > is immediately registered with add_or_reset_cxl_resource(). The
> > rationale for keeping it is that it forces use of "no_free_ptr()" on the
> > argument passed to add_or_reset_cxl_resource(). That in turn makes it
> > clear that @res is NULL for the rest of the function which is part of
> > the point of the cleanup helpers, to turn subtle use after free errors
> > [3] into loud NULL pointer de-references.
> > 
> > Link: http://lore.kernel.org/r/170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com [1]
> > Link: http://lore.kernel.org/r/CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com [2]
> > Link: http://lore.kernel.org/r/20230714093146.2253438-1-leitao@debian.org [3]
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Closes: http://lore.kernel.org/r/20240219124041.00002bda@Huawei.com
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I guess I may have missed the boat on reviewing this one, but if not
> a few late comments inline.  
> 
> Jonathan
> 
> 
> > ---
> > Changes since v2:
> > - Drop kvasprintf() usage in alloc_cxl_resource (Alison)
> > 
> >  drivers/cxl/acpi.c |   93 +++++++++++++++++++++++++++++-----------------------
> >  drivers/cxl/cxl.h  |    5 +++
> >  2 files changed, 56 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index af5cb818f84d..32091379a97b 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> 
> > +
> > +static struct resource *alloc_cxl_resource(resource_size_t base,
> > +					   resource_size_t n, int id)
> > +{
> > +	struct resource *res __free(kfree) = kzalloc(sizeof(*res), GFP_KERNEL);
> > +
> > +	if (!res)
> > +		return NULL;
> > +
> > +	res->start = base;
> > +	res->end = base + n - 1;
> > +	res->flags = IORESOURCE_MEM;
> > +	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", id);
> 
> If you are going to call a function something as generic
> as 'alloc_cxl_resource' I wouldn't expect to see such a specific string.
> 
> alloc_cxl_fmw_resource() would be fine with this.

This name was chosen for symmetry with the existing "del_cxl_resource()",
and it really does feed a generic "CXL resource" concept since the rest of
the kernel does not care about the ACPI'ism of "CFMWS". The kernel
considers these resources with IORES_DESC_CXL specified.

> 
> > +	if (!res->name)
> > +		return NULL;
> > +
> > +	return no_free_ptr(res);
> > +}
> 
> > +
> > +DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
> > +	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
> > +DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
> >  static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >  			     struct cxl_cfmws_context *ctx)
> >  {
> >  	int target_map[CXL_DECODER_MAX_INTERLEAVE];
> >  	struct cxl_port *root_port = ctx->root_port;
> > -	struct resource *cxl_res = ctx->cxl_res;
> >  	struct cxl_cxims_context cxims_ctx;
> > -	struct cxl_root_decoder *cxlrd;
> >  	struct device *dev = ctx->dev;
> >  	cxl_calc_hb_fn cxl_calc_hb;
> >  	struct cxl_decoder *cxld;
> >  	unsigned int ways, i, ig;
> > -	struct resource *res;
> >  	int rc;
> >  
> >  	rc = cxl_acpi_cfmws_verify(dev, cfmws);
> > -	if (rc) {
> > -		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
> > -			cfmws->base_hpa,
> > -			cfmws->base_hpa + cfmws->window_size - 1);
> 
> Not sure how this is related to rest of the change.

Recall that in 5c6224bfabbf ("cxl/acpi: Fix load failures due to single
window creation failure") was a fix that also unified some of the print
messages in cxl_parse_cfmws(). This follow-on cleanup finalizes that with
conversion to scoped-based resource management and removal of redundant
error messages.

Otherwise:

__cxl_parse_cfmws()
    dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
            cfmws->base_hpa,
            cfmws->base_hpa + cfmws->window_size - 1);

...duplicates:

cxl_parse_cfmws()
    dev_err(dev,
            "Failed to add decode range: [%#llx - %#llx] (%d)\n",
            cfmws->base_hpa,
            cfmws->base_hpa + cfmws->window_size - 1, rc);
