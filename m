Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A1173350
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494384; cv=fail; b=jmHu2Ne9QmG6eAppc3Gr3GEVQo2CWM/TvHvXb6sdoGb+z7tCA/0vs3CEa/AdAkCAog9/+fcvKa0irUeYcCvgkUVHSBer6ZF4FOg/Ly8Xw1c2h2uBQlmIM9HoblGsoOUMhGiw0rvlMBB6wCUJrgQG9kvRYHpiNa16rDwl75KIO7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494384; c=relaxed/simple;
	bh=jevglsDxQF+OQmc021E0bzjz2DVkqLQdXNsi4m/zjwk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MUIKJMzE1Kf6z4Wrl9DboBC+ESfoTQmPR2MZKhFPziD7Twsh+wwPNPZRrl0UutQ09mAhslDd7wfxg2IMkwPO9QV7gbWc3Z52Ja8a6YDg+QEQ+obOplAspnRUlxPsbcn6/kbMFC55n3wMyTTt+ME+86ESPPx6wc/lEFKHbY6I0wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLTkPmWj; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLTkPmWj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714494382; x=1746030382;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jevglsDxQF+OQmc021E0bzjz2DVkqLQdXNsi4m/zjwk=;
  b=SLTkPmWjZDIAyKCAjNY4AhPPsolNs1qT2UjgTCwBznSUNGpLxmHfmdLw
   pPk4FwKSGpK2shmuYeQLFiTHhaFzmlnI/KC4UwLc51EhiEiqULVnDnvrX
   c9DOF8Iy469WKFdUzo4KGESOBwIb6qy2d8/GbO57y+2GpmwtVlb78W8GO
   OeoUyUbHhAb6nDRuc4HQn40njDA5GTDpCk0vRAWVl/o+9rWdQ5/C0N018
   z8WnNvrc+fj+G7JhmZW54bPwoRa1tFIXljDS2T8JVQV0sGOXigtrLJVac
   X73muKxb45ojbdQ7PS1QItAGUhj6vrssb1gES3UNV0ceBKHVswZIme07v
   Q==;
X-CSE-ConnectionGUID: 50229nosReqB17M6b3OguA==
X-CSE-MsgGUID: /UUn6FRyQruVk3NYtHrauA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10083880"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10083880"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:26:21 -0700
X-CSE-ConnectionGUID: 8Kurb0PWQXqsB7d+JzoyVQ==
X-CSE-MsgGUID: k0D5h+TQQ/e3Z/NtmAl0yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26526077"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 09:26:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 09:26:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 09:26:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 09:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG3TUomo/Ts5RLdJ8pjtJbyXI9w07L3vN3648YL6BcpD4k3/O+ur97yPwVxzsT3raYvHTQw8JCa8jKDCkKcoc35h0fPDEB7FSiwLBYAfbp+aO/LLwC+3Lw77ppPwZMz7+hmLMDv7Ufdywimx27FkeEtrRE73SGn/dxBb2GSOcaEV0y8AT2MVcbGJQUZrOgD/V6Ca9tiowKqncYa3ApfTEXyHbxQEtxTPVXTimc1F1azpacV1nWVT1lgw8+seyI8ZJlqPlcP0t6LKGTpY2pu6JMfSK0B/cuHIpDfBqo5Byso4IYeps3GzmYpfXEhknl+rbOrILnL0WkZKn2lIPEV+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeQC43xsChKYTsCf8Q/1wjxSnBIrs+are7xxbm/1sz4=;
 b=bOdpzLVgPiJvgsXWqFJBSyUePDlirXRX8m7OkSus/ZYEPziKHzj8V6olcOtHqkY4N3aqnFTa9xbplrFTfeZZ2LEHv/9atp58qa+q4ZxdtOnJvnBe5DaPsqHyoQUKkkqQqBhe4LYk5lz6Fw+eiU2MCqORX2FOn76A49Qu6gi7jRC7HHkvWelsf3/141VmvH+EyrjiS+u0bBJ44yrffWg8xV35nrkSQYZmX8oqyGV7xWxcbdukMYxIrkOdTmpNFNDhuQVAEzbHWS6MxBVYPxAbgynuIyiVyDjswwpSBrFEHUF551lGVHvbr15RU2B7YVUJuoc0zRKXM2z73A4nwrv4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 16:26:17 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 16:26:17 +0000
Date: Tue, 30 Apr 2024 09:26:14 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Shiyang
 Ruan" <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v5 4/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <66311ba6a186f_1c235f294e3@iweiny-mobl.notmuch>
References: <cover.1714435815.git.alison.schofield@intel.com>
 <ff90c45820c502c5f39c671fb159cc7b2ca8123b.1714435815.git.alison.schofield@intel.com>
 <66305516ba200_1b13712942b@iweiny-mobl.notmuch>
 <ZjBv1zWDbdYYtjQ5@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZjBv1zWDbdYYtjQ5@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 411b95fa-7338-485e-705f-08dc69324310
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n69esyBqRxvbtDNOM9CZXllQ8upeCTg/cn3ikvx930viw6qEndArWZNKLvlC?=
 =?us-ascii?Q?CkS6axaUKB/FKHiS248k9Obj6JTX+I+Mc/P4Jg104/9iH/sOqi3FF8VBN5TM?=
 =?us-ascii?Q?4glN4tBoNSt7oQbFlavoHXmD1eMCIRMUtcf/2SRES7pqJJ8+WXH1kzXVzZ6/?=
 =?us-ascii?Q?M3D1lUjDsRbXulGNiRo2b6hDq5AqDi7oc/URQ8OUlevPWK5hfOssCPvRUUDx?=
 =?us-ascii?Q?knAvaPoZUjl3E9rEDrRl64kP1bXysnauP9cujKsvDS1E3GsHNcEUa6i0M9e9?=
 =?us-ascii?Q?l5iN89Nf2rDwbR+9TYRZgBcQDFbg5Gtx4ATNYxA6ReAj9QjfRzPkuDkTG1ng?=
 =?us-ascii?Q?+Aqqm3Z8FODw8m1g/uhej7jPoxme6yVMBU5ffaSwgBh2pXF7lIHArg5hTYsN?=
 =?us-ascii?Q?h3oD5OJ5rPpJNQe1ajBhkqn5wQAbEzKirjbqratlKBwakifdhCEUnoiprdXE?=
 =?us-ascii?Q?y7TgxPAYnqxJyZ4oF4aAvtqe2VJr4+vhbDDOHi2fsFUH9fpy3nWA8Q+OQ++c?=
 =?us-ascii?Q?bADFmmgE19IR2vQI6NnLIN4iEQryMsanchAEIMYgIuP4QUPjMsc9UFnpxRwI?=
 =?us-ascii?Q?5GehiA3/GHXUmePbhD4y46aZ7RYtqNsBF4n8D/NQtYDhrtixRyObdHw5J/lG?=
 =?us-ascii?Q?uvj+6g9+wS97oFLhGjq2BDl8jAPn9pIQEe6PDtsOf9zgz4TBIxHAgjDAGP/n?=
 =?us-ascii?Q?5nUQlaNwTbJzIjWOCbtOPHHY0bkNYjnmThuDolRJCe771hu3wRoabIQrhg8B?=
 =?us-ascii?Q?YJRgrDTODvc7dqctUqCTdpmNvaPAwXMTVUqoEAIqpTZ8RMmdkShFXMjZPb0o?=
 =?us-ascii?Q?/QvrEtUi9u9XOo32AOKNQBChhw8Mdt92WBojTywknAnXaN7SDv9VF9SQuVW2?=
 =?us-ascii?Q?ao+52veNnfAeToELr72BXeG/jCb6OufYoeqx9TyIsL12G98/Iegl+Y2+5f0x?=
 =?us-ascii?Q?K1bk5iLW+T4XYH5WWiGLCmCg9861MYZWZNXxTCrL1OfnJLNxFynR3TB7uTy5?=
 =?us-ascii?Q?fecRelvvsFGgMiMXmEs27N7QdjIz16Ff+iGUq1GdseGB0H/biCJn/4HXqkN+?=
 =?us-ascii?Q?rNnmVWvuBAso0MqhvNqDaH/uZjUfiyyZGrm5XnwbIB6i42B3Njn7Aw9Ccdvl?=
 =?us-ascii?Q?qA8G32kYLIH2CFuSLPnI9S43ZhZnqadzsqScLfQB7Gjjoxrv4vTSVczKO4OA?=
 =?us-ascii?Q?J/6qgFJuTxbA3FueGXPoyV/1gp9Cjumbjoh4r7fA6xOzL+rc7F84dlYr1ifc?=
 =?us-ascii?Q?A18pkbuLto/lKSKIqjRJC4DmFGCv0lEn/AqUh3MpHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yPrFYJ7GXihhYVXSP6eULdq1Gf+YeOQ0vKu2lKwdlrV7cdjkew7Xif3KZBnW?=
 =?us-ascii?Q?/fg4Z7aTfO11muRIAsihZ5t45kSDCT7tclE9LLSyA89FqwuFbPkGW+J3zcZ2?=
 =?us-ascii?Q?3cQo9yh1zYHpkrzKPI/qaU4Csi/77bf1T+xyDoivUBr096el05yMJOwsnu94?=
 =?us-ascii?Q?rh4lbgUt8X2XPH+HyqC7duyl8Oym8aDmBLE6OnY8afcdQVKAMeKQ27kw1LNZ?=
 =?us-ascii?Q?YuPf+MR1Fg+Fepqstv6St49d+oilOga6jFqUOIZXOw8qkCNCiVwfCpcns/5d?=
 =?us-ascii?Q?jG1En4qzBMW1Kk4ZLpc44BrQ0m6k4Y3xtSgXUyvD1IBiKYgtRUp05I4TAGLe?=
 =?us-ascii?Q?JrPylUzI66x9kO5t70UgxfQtODURIT0TG6FlGPA9HqpscT3tmaBMJAL8v+Ou?=
 =?us-ascii?Q?DZiwBQUmkoDo+xpaBfnipSJztp3Qt+H/Z7n1x3CVwRuhgloFTZe2E4MLkH/6?=
 =?us-ascii?Q?9wWCWkTXE7oZ3YABfAd0gUPbtjyREk71sAQ36cu/4G00jr66ViA7AriLMom4?=
 =?us-ascii?Q?8EyMNhvgqy2imVflaaz6WqPyZeG20qj7yZ51Hy3OdqxgEf9Kcxu3TJ/YmmVq?=
 =?us-ascii?Q?HKHZazTzjvk7rKEicYz0mvTp7kH67zfmfChTkJBfwZ5YKttB+nApBgpVDu6i?=
 =?us-ascii?Q?Remwdpb4GyG55z6WSCpLAugc2IW2VO5xVTuwpOkWX8HHp191ZhYu7QNcjRE+?=
 =?us-ascii?Q?8jg6oDxueCEQ8s2hmpN9pG83GTSfaRI0ehtszFcat8IBHy0LyFaG7dOXHzbl?=
 =?us-ascii?Q?LW5posCN7QYzJu0dPNpyapUsLbPBkUOyaXeZCQhW2q9deSHIfVpC5FnaSuIK?=
 =?us-ascii?Q?lX2LWCE+EA5mLUm9ao7dGPADTgFSaFuNfs+J0I36bJpQVrmOXkbAsfdfJInt?=
 =?us-ascii?Q?EECpWtsyPnKJfDTdg03/K4A1gFzPoi2pxDNEmU8Y+jPszqQGYQQEqzx2AwjY?=
 =?us-ascii?Q?ESaWexmWIbprfSTVy++Fkrbtw9XiSVEVVcx8mJ91t6KD+2skTeXClUGRBus5?=
 =?us-ascii?Q?f3V8q1/59e3+7DpLgsN07K2I1tn/o2VmGK2bdLtEOPu0y4WOr4Xr/7EwNDMJ?=
 =?us-ascii?Q?kTnVLi8Yrr5BGnrO8JKJU2l5SUBgRKkqZG4Ol7/mGz71QsLrPLR39P7YuUPZ?=
 =?us-ascii?Q?+d6QZ/o0XfcQYqiThQvLBlEWbxugGTffBTJCw6BGssjmlJ8BgItC2cFOLzMp?=
 =?us-ascii?Q?caaRUdMnNn4DaHkwDwNh0LQ5iRzNdCSdFoHx++4aDzvRlSKsEplR7vPZ7ILM?=
 =?us-ascii?Q?MeXENGBxO1TUNsF/qx2ET/44DIUJrXLWtDHUQjZGX9a2rBUhY9M/TQMzg+LQ?=
 =?us-ascii?Q?kmdb1eBVhcKANlGtx4zm81VKF4jsJlG69hPgMG2x3lEhAVZvjK6h74dnA10V?=
 =?us-ascii?Q?jpuRX+LuehVdwKHw2P2tcwbjvOzifQc0Z6Tuq+uofUQYvW45O6GMtOJzgymX?=
 =?us-ascii?Q?J15e1k5IoIWjlsLBQDjS/Ht+6zbvNk8QuKEVrZj2ugFFF9M0C+g76/QMol91?=
 =?us-ascii?Q?vnnRm/YU9We5fKuBwcHhjWz9UwmT0sILtv9vLCrfnR0JZqkMuneaRPijMviK?=
 =?us-ascii?Q?wtNfxIyz6IzWpVBAMxYx+rHFJ0MZ2XrXm9MgSVUy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 411b95fa-7338-485e-705f-08dc69324310
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:26:17.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QayPFIydK7Ot+sWnuyFCmjBNEJWDhn4AtIssnAwhJqtI4OOMjatZ+AEplzAcffNyZNao8rox67D56WQWzxTGsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Mon, Apr 29, 2024 at 07:19:02PM -0700, Ira Weiny wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > 
> > [snip]
> > 
> > > diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> > > index 03fa6d50d46f..5342755777cc 100644
> > > --- a/include/linux/cxl-event.h
> > > +++ b/include/linux/cxl-event.h
> > > @@ -91,11 +91,21 @@ struct cxl_event_mem_module {
> > >  	u8 reserved[0x3d];
> > >  } __packed;
> > >  
> > > +/*
> > > + * General Media or DRAM Event Common Fields
> > > + * - provides common access to phys_addr
> > > + */
> > > +struct cxl_event_common {
> > > +	struct cxl_event_record_hdr hdr;
> > > +	__le64 phys_addr;
> > > +} __packed;
> > 
> > Was this left over from a previous version?
> > 
> > I don't see it used.  Nor is it a defined event in the spec AFAIK.
> > 
> 
> I introduced it in v4. It is for the 'convenience' of getting at that
> common phys_addr field. You snipped the usage away. I'll paste it back 
> here:
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> 
> @@ -842,14 +842,38 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt)
>  {
> 
> my snip...
> 
> +	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
> +		u64 dpa, hpa = ULLONG_MAX;
> +		struct cxl_region *cxlr;
> +
> +		/*
> +		 * These trace points are annotated with HPA and region
> +		 * translations. Take topology mutation locks and lookup
> +		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
> +		 */
> +		guard(rwsem_read)(&cxl_region_rwsem);
> +		guard(rwsem_read)(&cxl_dpa_rwsem);
> +
> +		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
> 
> Used above. OK?

Ah sneaky.  It was not clear to me from your comment why this new 'event'
existed.

Ira

> 
> +		cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +		if (cxlr)
> +			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> +
> +		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> +						&evt->gen_media);
> +		else if (event_type == CXL_CPER_EVENT_DRAM)
> +			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
> +	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> 
> 
> 
> 
> > The rest looks good.
> > 
> > Ira
> > 
