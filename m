Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12952248B9;
	Fri, 11 Apr 2025 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744410285; cv=fail; b=SLCD9iGoJZwPjtxfsSvJP0963NcBpe4xT94Fa8K92K04QrlteeF7j8r9lz+AgWEosN6NBaPj2I1KjuTyYrz3SqoyAD9tmNXsN4iqh1mcM6ba/G9rJMlZFLk8hVUJjnFSengJCcE2foIWILxabas+anl8WxI//nBGKwgrOjqsE3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744410285; c=relaxed/simple;
	bh=p+Eaile4YymwXI/DfiLGTZa0+SxiUa+sCpANiLrYXlk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H7iy3EDhDJLC1IXdziG5CIhGfo5NlHo3n+oeW47vfs8aKkPkhBr6VbchYC2SjdsYNXKwSLO22sQN64NrDGCpXsFy/9VPpdDakvkXf51jmN7l/sTeHya9m1J5Ko3+UOlFTlPl4YqCzyg+r2bISXiL3QCdZkt5yLjFGZBSXIYvgk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJ+2f7tq; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJ+2f7tq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744410283; x=1775946283;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p+Eaile4YymwXI/DfiLGTZa0+SxiUa+sCpANiLrYXlk=;
  b=DJ+2f7tqDrXG7aIghv28DOeKaZRmshWNpEcKuCbY53C7p6EzKk8EmCOY
   38okoTZoHki4VWNSefC7/l5Sq5XOc3uP3TBONVsc8GqdamE/S2fl6aenl
   pjuTJldJs34vTFf7KiN+FuXMuaZRu5DxHAGfEuGDwrOsOmuUkHKA8lSLF
   qvyEW3IHo3bLLLIY9wE0x/WgYykuwP/c/TOz6PYqTuCcXyltzBOoVHEtL
   wXF1Mf1NB+ZxCsL2qXTEDXaQc+2TnHgD51e2CO+GA6KD0Lazkq0ClgZr6
   X8OrjCL0QniCY+9DwO+DJ+GGihMB5uUJrXs5iohuc1wf3VShblKhmGFDv
   g==;
X-CSE-ConnectionGUID: N8nxpVC3Sm6rfFkzU84ngQ==
X-CSE-MsgGUID: qui30oVjT06JewdA6WIZYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45211463"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45211463"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 15:24:41 -0700
X-CSE-ConnectionGUID: RuM1eQhyQsKThue2F0PeHg==
X-CSE-MsgGUID: mHZvFWEfTEyblK3DbYtvlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="134060209"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 15:24:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 15:24:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 15:24:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 15:24:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/GpHG+yEY11jbhTWz9emk7j4WeeGUgdA6cnlkufwb5o8sqVFDLmGKTskn8sti5avj+5u+JtCjj278qJD2jpc44dYHqhqOlAGbjulMsKbY8PlSABcCaSV8g1Sz2/vIEpBEAu/qEHWVhqwgrKKJnwB+F8JPWHGp5nuvm4D8VMyWp4q42m32PGxEUBt8N9Kj9jvHdjHsku6rtrC7j3Ne30ANeuBjm6TGgdmInHChod0JRm8Zm7+XjKo3yvDTQcjVUBkbEPLgAuWlPP9N2ec9kWhUFV+sfeOtC57OeHx8iJdA39jARJtq50z90AnQi3COSxvEPDUeU9DybCJ6fmMTImVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dxo8nxj1vN6RzppbEUnec8fk6xsx8VYQyqkf4wciAw=;
 b=UNnVaF48lF+CfCV4wpM4kNlG69r+oZL2fok03VfDzA6Ip6xIGn5hkdMGv5pf7/Cvfoz3t4EdfdvvtTxTqtfTR3CbdWhs9eF/Z1SfZoZ5wWPI8R4HDGAAXeHMnpDCNK5ZaVQH4xxzRbCnqHyXTMqPDrPlx8uJcetQs/e7XchlnH10wehd2SkaTWmrQ5dac93G56LvEZiuloEqr6VpIAXvyI1iN/3BPIdkXclOKWxmoD2wIbXR36JDjw7awU9SfnYMYZ16BkLM0wPGG+bNpydh/PcdKLygSLQnGzz1PcIk/JKBdYH6GUk2w+KPPDCR10H593Pcom4mTfKHTZtRBXmUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7676.namprd11.prod.outlook.com (2603:10b6:610:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 22:24:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 22:24:05 +0000
Date: Fri, 11 Apr 2025 15:24:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Rakie Kim <rakie.kim@sk.com>, Dan Williams <dan.j.williams@intel.com>
CC: <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>,
	<Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>,
	<rakie.kim@sk.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] mm/mempolicy: Prepare weighted interleave sysfs
 for memory hotplug
Message-ID: <67f99681d3e60_720529435@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250411072135.588-1-rakie.kim@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250411072135.588-1-rakie.kim@sk.com>
X-ClientProxiedBy: MW2PR16CA0060.namprd16.prod.outlook.com
 (2603:10b6:907:1::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 6095350a-7423-46ba-1a81-08dd794791a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O5ycxYsLCEaP8c4tDqbXJGL8vcC+qTo4tM6O3Nyq8SfpHwXXoDOlcd4FDnqr?=
 =?us-ascii?Q?qZ6AXAGh1qG2iMT24Q4rGigM9Am4L34G3nhYwjAdAxDSJ8LyWIzmT9ssmy/z?=
 =?us-ascii?Q?BiIT0O9XA4kvYY/+nOavNOZQ+Ykavd8/YLQvQlEamY0I1QQhr71Cc2qM20qW?=
 =?us-ascii?Q?tSyuChxh+BbQ+XJL6vDrA+NpsLxte9cmt/fc6y2nEcYwoU5U2M4FfXIK2rty?=
 =?us-ascii?Q?uU0r9LQAXroKPzpCWMCPjRtT1NhAQrnuguig5cKAVqI0IsvF+dBJbH7pbIDk?=
 =?us-ascii?Q?VLOnZ9AE0tRD3P+J5+L1syZJj1hS+5+u4+fIkEK1TbvvLHJkWcR4pFe4wasU?=
 =?us-ascii?Q?jbFb/HktNczgiV4ygoOp1QuxDzcYWzj131kgcofhTeCt2veT4gYJnBqFkifC?=
 =?us-ascii?Q?t/vsP0DoksrPAbjlAeGmsIPo+NeSllsZofMENDMaWf4G3IaIS6Z3KiMNOETe?=
 =?us-ascii?Q?e8AdljLxbL1HjRNcCdQHJ+Fn1vxG9v6S1DY2E4fmfcA66i3W8269FyzLhE0z?=
 =?us-ascii?Q?5aF/8QM3lvvhBXvdQxDAUePpwfCl2hpJKpR7OHeZbAh/xo88UIPT9SGICvYy?=
 =?us-ascii?Q?moPjPiUdEx3NSYgvniZL8ehmPtX631jPwpit5uGGTx8BgT56tf6CZlWOjaip?=
 =?us-ascii?Q?m5tXQUx9Wr0uIhcQuO5m0n8ZfarvB/LZW4RHNmwnzbq3Lky3k4P4sKjcP4kW?=
 =?us-ascii?Q?9HiPT88f32k6DI1yZKX9+ri02EAjhs2sB+Ra5VE3q2ENFKP6WW03teOSRoOy?=
 =?us-ascii?Q?WSpy0apQqTJMIkrOE5dSAqIPZ7Y9JXSuxCF3aAQlVK6bU/zfyyGHv22XcCiy?=
 =?us-ascii?Q?Rz08Aq/9oiOt2YAmE4M22CyypFwrvqQF82PNXyG0h3ePNli8rJ0Sm1aiBUSA?=
 =?us-ascii?Q?tU7f7KihSyRMaRCXyiXcn8Q1wsoo//1Mg3ZA9fCFCtTkbb2/QT3xbi384M3Y?=
 =?us-ascii?Q?EkbE/Jt/ID4az2ggTERG8wpzJNI0rfY8STUtIvOK4+O9RLMnExnq57i8VEBV?=
 =?us-ascii?Q?PMe17UwgUke8MzxwfxfLDNnEnklrb5ocD2ECS0bCnR4Q5sXfVm7fG4XTLwFy?=
 =?us-ascii?Q?CAkwG+FrXEq0ijkF/pqBHb/S/KMT0auSA/9r+0tbpqWoKG9PUwkLL+gXxKCt?=
 =?us-ascii?Q?mzKCWALg4iINkfWdP5wOb7qXJuHMjDI2ylhd1vDgsvg//RdhoDNi1FPnHLiu?=
 =?us-ascii?Q?pJhKKHWs+Cft/L0/oBcHaISKcsG/LRcBiHTQqryIhIPh2i/yGZvVxJzXyb7Q?=
 =?us-ascii?Q?3xP32XJj0mCyvVD7kWgwRN5RKo8QbxKWFJIq613rPqmaOy7/pcvWknDZft+p?=
 =?us-ascii?Q?SYzUaJaPM44+BHW7HYWNhiHoudNBbeJwWVSHWuKh+kXWNiCLXUJM3MzWLh9n?=
 =?us-ascii?Q?NRpd7eg0ai9b/Z+jz2rowqHl8+b1tFmB/sFHAxaCM78q1JbQGreQ2Pu/Q/9i?=
 =?us-ascii?Q?7Le+WkgVLbw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Xc9ZxVsWCl7MjvgexDMBLY2HeBjteRljELDe5ixZYhhkSOQNJwQhcZ2eGWo?=
 =?us-ascii?Q?qMumQaeMDqEq82ZjDkU81sv4QJyIvokSEey01kTeqLO+GNoUFRx9kSbnan1V?=
 =?us-ascii?Q?KkNYqDpuP68T1RI5hxT8iC/F/DG06o0ctDxLXAYDoWpb7u1yfI+QNQKHD13A?=
 =?us-ascii?Q?Fh7jKi+OVBq8u+hZKVBY1D6TGY/zfNWmsSUQpjH/ok6gCGPAsecSarkb20vL?=
 =?us-ascii?Q?0frJM5N/XzafQ2aph7iNoUSUBqAQnRLBA1JH1pzSkaJTIpMa9jZXnWf261Gh?=
 =?us-ascii?Q?wOU/YYF5k+IIxaPyPTI2L6xAPZXisdDUSZVzCwdvIB8tKB1OXXNc/oM6CEt2?=
 =?us-ascii?Q?vXRjQVcmZd8Pl2+dwoL8BdW0XqK3u1bKuz1rZk5udX6k983hhRnkF+psiBxx?=
 =?us-ascii?Q?8/IwmBCcy1XnRVGakwDpBjQcW/U+Hw8hfadbMDseWOlQjhGwjkdbBwvFljMc?=
 =?us-ascii?Q?Jpb5oF9Af+0lFulOHRLp3rmSXVzWlAwZlSAdtZG187doERlCV3+B4ypbbr9R?=
 =?us-ascii?Q?MIUnv0d8//jMDWagRWJA0dRIcaM504PoJSt6mRhUa89BNWe1mIgEV/UD/YWR?=
 =?us-ascii?Q?XOAovPMwmwajMSwVmxY8c8q9l6GORJmUGLqj9Tptx5NubJJ9GdRpTRd9LJs9?=
 =?us-ascii?Q?dpwhZgz2BwcjCZIkGcrd5AtDg/iMjbASVZgF4XnEGmdgehSEjBmQ84yCNIwT?=
 =?us-ascii?Q?OpM6OBebxBDbVlPfpd+AkiRtvCZAnZr9+JfS228iA/aacuqgsb3vhBA+ChLj?=
 =?us-ascii?Q?50H7AuMOORv1EzYlG1nX+hVUUc+HLww0OqDKm6MK22fyHBuNk1GMYabkjzpC?=
 =?us-ascii?Q?9ICxAxvaEkKxLUnT2Nwimj2dl9C9bLq5RLZA6avUUaDEl22az9HTEW0K+0gK?=
 =?us-ascii?Q?6f0YaKbHTI+gzkppakZCR2MnviPM2jt1zwZai/yBeF4IGl+ctfq2w2z/9Hee?=
 =?us-ascii?Q?HSz3eKiUDlxlZW+6qcgEkKlSq9t7G6aoz5r2OdoXBMtNInOh3zoMg/5CLGR6?=
 =?us-ascii?Q?Tg0hWPPJTeAWixv9hYAfZ/4FVjaQLg2eazE5ADZG69rGk/XHezMRSA/byH9N?=
 =?us-ascii?Q?CIzP+HMtYdBzomg6Tch5bMXsyc/fYrJdfuIiw6WqRq4DamZAwdJpyfc8zq3r?=
 =?us-ascii?Q?LuwnT7d29nq//s376l0thQrNqJov/GygEHKrfLRbiqp+o/HtSqYRJ91dBcQi?=
 =?us-ascii?Q?WJdKkEvnmUV16GVd5zbpOR59P82430hWWWsypQjKvOazZ//x95X3ndd8007s?=
 =?us-ascii?Q?YcVdRVLVQWlaj6fconVwphfXpt3NQYBOiJWR0Jg4Q7+vMB2oetI/lsVXWbBB?=
 =?us-ascii?Q?tbg584a/oIYsoF4wjThXqVpMMR7Gl1lmBqI+RWvof66SifUAUQAOmuwvi6wk?=
 =?us-ascii?Q?fS0ZtJ3L2Zm+l3VFl17ERz+T/bKlknzECFwgrkg5fmWEmM9D1GlXBALZrlRw?=
 =?us-ascii?Q?u/VUFsQw22ac9o6MSM8fIJC8t+dCRQrryJgudw6Qq4RQ3oRrIhE21GJhyg0t?=
 =?us-ascii?Q?JmksTSkb5hpJoAm6GVEu58l2Tbz5XUGaSvwfan/dXLhd1Kq9zafq/p43wL83?=
 =?us-ascii?Q?73IWR/nM0yiPr/tOUTE03mr5PMp5LVtPK7TN0GwLwBokP9OcdldIzusgqS8V?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6095350a-7423-46ba-1a81-08dd794791a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 22:24:05.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qid4gQER28czJwnqGeelgB0DTFnJtbXJKZVgot5r2DqlH4aaZ+eX61VMiNA+x7ssjnlyK8FiNU4vzdioGEjtZy7MV4WxLKaGuPM3PE7VqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7676
X-OriginatorOrg: intel.com

Rakie Kim wrote:
> On Tue, 8 Apr 2025 20:54:48 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > Dan Williams wrote:
> > > >  
> > > > +struct sysfs_wi_group {
> > > > +	struct kobject wi_kobj;
> > > > +	struct iw_node_attr *nattrs[];
> > > > +};
> > > > +
> > > > +static struct sysfs_wi_group *wi_group;
> > > > +
> > > >  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> > > >  			 char *buf)
> > > >  {
> > > > @@ -3461,27 +3468,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> > > >  	return count;
> > > >  }
> > > >  
> > > > -static struct iw_node_attr **node_attrs;
> > > > -
> > > > -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> > > > -				  struct kobject *parent)
> > > > +static void sysfs_wi_node_delete(int nid)
> > > >  {
> > > > -	if (!node_attr)
> > > > +	if (!wi_group->nattrs[nid])
> > > >  		return;
> > > > -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> > > > -	kfree(node_attr->kobj_attr.attr.name);
> > > > -	kfree(node_attr);
> > > > +
> > > > +	sysfs_remove_file(&wi_group->wi_kobj,
> > > > +			  &wi_group->nattrs[nid]->kobj_attr.attr);
> > > 
> > > This still looks broken to me, but I think this is more a problem that
> > > was present in the original code.
> > > 
> > > At this point @wi_group's reference count is zero because
> > > sysfs_wi_release() has been called. However, it can only be zero if it has
> > > properly transitioned through kobject_del() and final kobject_put(). It
> > > follows that kobject_del() arranges for kobj->sd to be NULL. That means
> > > that this *should* be hitting the WARN() in kernfs_remove_by_name_ns()
> > > for the !parent case.
> > > 
> > > So, either you are not triggering that path, or testing that path, but
> > > sys_remove_file() of the child attributes should be happening *before*
> > > sysfs_wi_release().
> > > 
> > > Did I miss something?
> > 
> > I think the missing change is that sysfs_wi_node_add() failures need to
> > be done with a sysfs_wi_node_delete() of the added attrs *before* the
> > kobject_del() of @wi_group.
> 
> Hi Dan,
> 
> Thank you for pointing out this issue.
> 
> As you suggested, I believe the most appropriate way to handle this is
> to incorporate your feedback into Patch 1 
> (mm/mempolicy: Fix memory leaks in weighted interleave sysfs).
> 
> To ensure that sysfs_remove_file() is called before kobject_del(), I
> have restructured the code as follows:
> 
> <Previously>
> static void sysfs_wi_release(struct kobject *wi_kobj)
> {
> 	int nid;
> 
> 	for (nid = 0; nid < nr_node_ids; nid++)
> 		sysfs_wi_node_delete(node_attrs[nid], wi_kobj);
> 		-> ERROR: sysfs_remove_file called here
> 	kfree(node_attrs);
> 	kfree(wi_kobj);
> }
> 
> <Now>
> static void sysfs_wi_node_delete_all(struct kobject *wi_kobj)
> {
> 	int nid;
> 
> 	for (nid = 0; nid < nr_node_ids; nid++)
> 		sysfs_wi_node_delete(node_attrs[nid], wi_kobj);

At this point the nodes were live which means userspace could have
triggered an iw_table update. So I would expect that after all node
files have been deleted then this function frees the iw_table.

> 		-> sysfs_remove_file called here

Call iw_table_free() after the loop, where that is something like below
(untested!):

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b28a1e6ae096..88538f23c7d4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3430,6 +3430,28 @@ static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
 	return sysfs_emit(buf, "%d\n", weight);
 }
 
+static void iw_table_install(static u8 *new, struct iw_node_attr *node_attr, u8 weight)
+{
+	u8 *old;
+
+	mutex_lock(&iw_table_lock);
+	old = rcu_dereference_protected(iw_table,
+					lockdep_is_held(&iw_table_lock));
+	if (old && new)
+		memcpy(new, old, nr_node_ids);
+	if (new)
+		new[node_attr->nid] = weight;
+	rcu_assign_pointer(iw_table, new);
+	mutex_unlock(&iw_table_lock);
+	synchronize_rcu();
+	kfree(old);
+}
+
+static void iw_table_free(void)
+{
+	iw_table_install(NULL, NULL, 0);
+}
+
 static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t count)
 {
@@ -3447,17 +3469,8 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	new = kzalloc(nr_node_ids, GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
+	iw_table_install(new, node_attr, weight);
 
-	mutex_lock(&iw_table_lock);
-	old = rcu_dereference_protected(iw_table,
-					lockdep_is_held(&iw_table_lock));
-	if (old)
-		memcpy(new, old, nr_node_ids);
-	new[node_attr->nid] = weight;
-	rcu_assign_pointer(iw_table, new);
-	mutex_unlock(&iw_table_lock);
-	synchronize_rcu();
-	kfree(old);
 	return count;
 }
 
@@ -3550,15 +3563,6 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 
 static void mempolicy_kobj_release(struct kobject *kobj)
 {
-	u8 *old;
-
-	mutex_lock(&iw_table_lock);
-	old = rcu_dereference_protected(iw_table,
-					lockdep_is_held(&iw_table_lock));
-	rcu_assign_pointer(iw_table, NULL);
-	mutex_unlock(&iw_table_lock);
-	synchronize_rcu();
-	kfree(old);
 	kfree(node_attrs);
 	kfree(kobj);
 }

> }
> 
> static void sysfs_wi_release(struct kobject *wi_kobj)
> {
> 	kfree(node_attrs);
> 	kfree(wi_kobj);
> }
> 
> In addition, I call sysfs_wi_node_delete_all() before kobject_del()
> during error handling:
> 
> +err_cleanup_kobj:
> +	sysfs_wi_node_delete_all(wi_kobj);
> 	kobject_del(wi_kobj);
> 
> I believe this resolves the issue you raised.

Yes, along with the iw_table_free() change because while it is not a
leak, it is awkward that mempolicy_kobj_release arranges to keep
iw_table allocated long past the time the node attributes have been
deleted and shutdown in sysfs.

> That said, I have a follow-up question. With this structure, when the
> system is shutting down, sysfs_remove_file() will not be called. Based
> on my review of other kernel subsystems, it seems that sysfs_remove_file()
> is only called during module_exit() in driver code, and not in other
> built-in subsystems.

Correct.

> Is this an acceptable practice? If you happen to know the expected
> behavior in such cases, I would appreciate your insights.

Yes, there are plenty of examples of sysfs infrastructure that gets set
up, but never torn down for the life of the kernel. The goal here is to
make the error unwind path correct and make the code clean for potentially
deleting mempolicy_kobj infrastructure in the future, but it is
otherwise ok if the only patch that calls kobject_del() for an object is
the error unwind path.

> 
> Below is the full content of the updated Patch 1.
> @@ -3463,8 +3463,8 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  static struct iw_node_attr **node_attrs;
>  
> -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> -                                 struct kobject *parent)
> +static void sysfs_wi_node_delete(struct iw_node_attr *node_attr,
> +                                struct kobject *parent)
>  {
>         if (!node_attr)
>                 return;
> @@ -3473,13 +3473,16 @@ static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
>         kfree(node_attr);
>  }
>  
> -static void sysfs_wi_release(struct kobject *wi_kobj)
> +static void sysfs_wi_node_delete_all(struct kobject *wi_kobj)
>  {
> -       int i;
> +       int nid;
>  
> -       for (i = 0; i < nr_node_ids; i++)
> -               sysfs_wi_node_release(node_attrs[i], wi_kobj);
> +       for (nid = 0; nid < nr_node_ids; nid++)
> +               sysfs_wi_node_delete(node_attrs[nid], wi_kobj);
> +}
>  
> +static void sysfs_wi_release(struct kobject *wi_kobj)
> +{
>         kfree(node_attrs);
>         kfree(wi_kobj);
>  }
> @@ -3547,13 +3550,14 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>                 err = add_weight_node(nid, wi_kobj);
>                 if (err) {
>                         pr_err("failed to add sysfs [node%d]\n", nid);
> -                       goto err_del_kobj;
> +                       goto err_cleanup_kobj;
>                 }
>         }
>  
>         return 0;
>  
> -err_del_kobj:
> +err_cleanup_kobj:
> +       sysfs_wi_node_delete_all(wi_kobj);
>         kobject_del(wi_kobj);
>  err_put_kobj:
>         kobject_put(wi_kobj);
> 
> Thank you again for your helpful feedback.

Hey, thanks for the patience to get this all fixed up properly.
