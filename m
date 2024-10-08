Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271021264E;
	Tue,  8 Oct 2024 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414165; cv=fail; b=tR//mMoD+dKtZjE3IVQ/TGcU1NXKTpN9Jzn9wR8S2C16ITjXbSn8V1fRpc4x0PL4nLsyudBBlKnXWVpZmNPbPAHxPfXzQ9RNo5yQswIAkiiB3AYf8Q33dDVzVxiAveppZ7VtWm/fUyoK902SPPGD0iFJ0W6FU1Kz+/v2XxQt07w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414165; c=relaxed/simple;
	bh=jqk5md74xdeY4o2AqhqYdP8ICb6/Kr3W4KErTctSEC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Aza+ycFo+DLjJLPmwPyGra4d9MsRbnOmtjJmpbazlo9+tdztWf/3Vys8+35fRiJaeHuf8vXjtlBN7fpYj6ytWNtNQ2Ny2zFL0Jo7gPAoQ1UKus8NTkKuionPz6vH6Zz6mPkg6m8GsXLu4k9fK9oeKCqCb2TJAZKEvrn8LKMtI+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBYGEuE8; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBYGEuE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728414163; x=1759950163;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jqk5md74xdeY4o2AqhqYdP8ICb6/Kr3W4KErTctSEC0=;
  b=XBYGEuE877vDIorg4SIW8m2JI1XvObSHt1CTDoiYllXZZOZqq26Fg/y0
   VOHnB22K5Vb106qxsQLiTxULIbxbSU7RcClEBZS112qhEhiYS3eICsoEa
   ClaXIQfI8EMbw0G5TQbTHPQTHf90SvEuZjZtD4ABeERXv/1bI50Yz77kz
   Lz9Jv0KmCduajxpHvZy+wgPRSyVrzSLIYYSet12bswUPsxGB4nkvj3sQs
   TUYFZOZWoF/6DUhVo0lcaJc24GJpO8FUAOF77HGXcqlQyMGrvKkVMP5Jd
   pzBdvKIYet99aWPVnIM+fBd4eZPhTjaKQJ4SQKR2vF0dst+ajM00bnCKK
   w==;
X-CSE-ConnectionGUID: 3/3vn+dASBKw/VNQQRQ/wg==
X-CSE-MsgGUID: zyhPmjU+QhS2WyRBcStyAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38214136"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38214136"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 12:02:43 -0700
X-CSE-ConnectionGUID: jJWxnXo3Tda5FU55kfAvsg==
X-CSE-MsgGUID: K40l04pNQdKYI/gOjoKIYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="106789750"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 12:02:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 12:02:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 12:02:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 12:02:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1Ni5Py3bi/A/YSS93mZc/RqC1YuHgNQt8rjRfa/IDuOBiOaeIKP4qZ1fQUYgvC9lLVXrlCq/Yf0DmjBELc0w8kySR8XnzHhB4URGcwRMyYMAIKx5MpKzA1D8/0z9d3K8+lpRgM7vkurjFuEAD7FUDg6gudZw1cqsJKOIIjRVyniDv75Noprh7mvzXI8lsB+viz6NT5hSIgqY7CyRpjeJ3oeI6pdkfRLmUx5UClKYsJroENW/vGr6CVSOAXCgCXmw+wCZbELE3kwWARHJsVw4+vfvXb+gc0FGrhT/pf6SgZCMyYkmJKvxTLsfbtKnr/7+RiLEfPwOW3lFX+r5Vi7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqk5md74xdeY4o2AqhqYdP8ICb6/Kr3W4KErTctSEC0=;
 b=rWYeISqlvXFJy0IoWda7/dX/Mv32g/J5sufHsVZrcHhXFjXQnPAaTfR1gvMSaATZ2UPCAFl2RKmVi9qRFAePVbgr8kJWcVt/HDnK+1BDmmm7EYc0PjzlsQctA9i0q3o9cNX//yaoIMx3LVZlrnWdYiw6o6xbcJgDkvcmWsjCdBRy0+B90IYBpwmLSaDYfaqKzrI1czl9s1kButlyeQ3988z6dqgVAeK5R7+MLn8hqP5b8lra5wORTcv+jIkDC4wlFFf0VVVWmJK2J4kVKL9JP9LkoM/phdWqrTCz3fs3YCTgNmE79zgFCsJGH5ebITBzi/wya1fcMBZ5Yg/6mvwmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7597.namprd11.prod.outlook.com (2603:10b6:a03:4c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 19:02:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 19:02:32 +0000
Date: Tue, 8 Oct 2024 12:02:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Huang, Ying"
	<ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "David
 Hildenbrand" <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alistair
 Popple <apopple@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Baoquan He
	<bhe@redhat.com>, Philip Li <philip.li@intel.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <670581c5e7e_174cb329467@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
 <87v7z91teq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwPsYqkLF0eWUb9e@smile.fi.intel.com>
 <871q0rnw6n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwVlZROV84DDMCnc@black.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwVlZROV84DDMCnc@black.fi.intel.com>
X-ClientProxiedBy: MW4PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:303:dc::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb31196-0bdb-4ded-5c5e-08dce7cbc32d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OiEHWC45I4tlUsDjbysJm+nwPcABiSW1gq2GKmwijozHxPOVIlFZHafxdTBY?=
 =?us-ascii?Q?wu7WcIPP1YzxVXoSxRq+RwXX60OsVqL79WQfqDwfbtw7ZzGszo42+4xnyW60?=
 =?us-ascii?Q?jQPF4O3mUpkkLUlpjjIYPj7I/S28vnSXhE8gPsnwzzb44uLovgFoCY6eKQxR?=
 =?us-ascii?Q?n7zeXRc53yNYd3qQRGHA1rXzh0voaCRwMBTLAHud1nO1jyDRYFN81I169G3m?=
 =?us-ascii?Q?My3yXlVv3sU8gjjzQXlfbPCY91vamOlEK5VgMTDJDQ/AjXVHS30XXTLlpkq3?=
 =?us-ascii?Q?JXXQrmDImRjfCfdXcFc6yLGkv7l+8bWX26MBprgVjo/gsTJh7VpW+59jyrnF?=
 =?us-ascii?Q?tkgWgGr26eRQ4gO1z/bxs5KpGLVfIpaZB+LtMjVzI7fkHiGMUdLPuCFoe5vE?=
 =?us-ascii?Q?X/glQ/6twzxp0FFAqwB0B91dbGOjk2hcJWDSsMsc0mPYUGOTSyt885TnhOi1?=
 =?us-ascii?Q?J08JN1ih38XS29YxEIK/KJutl7sGlDxxyVq8JdQJA3MdSMURy6nmEGvbs4E7?=
 =?us-ascii?Q?DBDFQ8E3SeSTjCEzxM1QyjS7DDozuwjoiDwpiLssKyf3B57s7Ya+3e3RpDA/?=
 =?us-ascii?Q?OK+9hvvagAjtEENqf1Wv8quoHxZOmvzn8VDCI4AI3cCXPc7BEcjY9fVaU5M1?=
 =?us-ascii?Q?AJB+vNJsUDKOi3Plirr0qCjbF8MqYZU9jv5WFQCx2F64FFDuWt0C4gy8NnzS?=
 =?us-ascii?Q?jVnELEYfHlrFhhWP5WuF6sBqXfddcquCBbtiHqehaA3CWsow/c0NP+nu9Ddm?=
 =?us-ascii?Q?1rU6omTDsUh3sRKQrnYMUGlCcp65HeVYYsAf9Q7tyZeMqmbQipxE2afpuI8Z?=
 =?us-ascii?Q?/Q8kwLMEAxDRfuspBuY5SwO/V4BNgmsTmOHWavkTrjnwTLjbrTK8wmVg1h0t?=
 =?us-ascii?Q?/POiMwoo3sSguLsXvn71P4pupPNTbnrPbCUto73r4jFK0BS1a1FGhWBl53Bk?=
 =?us-ascii?Q?3/FtoMdcr6niMpCDskQp4Ej70Rt35uwD7+1LjZkUFTOZ3Q0etzejHJpqGXDl?=
 =?us-ascii?Q?soiTwTozwBP4mN47If9p26lEIkmHbgNz2n8msQknA/kj7vusmn55pUXlNoZh?=
 =?us-ascii?Q?O442z4ckvEpGGyDiQFFbi79wXcr9rDMm/bz2apW4nHSq3YzE343sdvAfJqhK?=
 =?us-ascii?Q?UIQoqcwCZfQ2ewzIi4yERknghl7hUZC7daycKEjX6i3st2756VCaUY8ygCWD?=
 =?us-ascii?Q?ayErhYCY0B27nyK2HQQ/FzeRW4aWSU2gSYbkBVg2q7938nETt03v4TlN77hR?=
 =?us-ascii?Q?MmX/yWsynJu1EcjKbhvhnE8Udrd1V+7Oy9rb0AxSAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9O93CH4lZeKl1En/ewhW3bxGzKDYFSzrew2kOsEeqxGGu70k9QF685QJPRv0?=
 =?us-ascii?Q?o3E/7DQ4liIfPZuS0utIYjpJXbf1G/TMCdSrFsIMPZ3RoKksLpKxEqZDD291?=
 =?us-ascii?Q?mA3JJ7qk/PjoJFJHI/m9DJ7gjgWgzKKrvDxGMKTtQ4y7qMRm+pUVZCk9RGp7?=
 =?us-ascii?Q?9Ky6Rt9V5Y3wtFVD4r4G1DlWGt9o/+tkaBNPkwgg5jLEwAU7tqLC/zQMddMy?=
 =?us-ascii?Q?R7IvG2S13FF4/OJppgrSfgBNfRU3vhsj4iqZ4S6wVWOhPFqzXLBfZz52VVhq?=
 =?us-ascii?Q?wCa8Q6Q17mBCJJ+zevglrz9d6xEzQEJGhvFCYftR8f2L0TGAtfVrE+qsxZGx?=
 =?us-ascii?Q?6FxEyoXvN+1Dhddci/eEca19OxFdQ+iTw3zFcMVi29yzitpDpE9Z+kNqPfBw?=
 =?us-ascii?Q?Ka6ieVDEXzW5eQSEaz28bCsptXPwl2aXiZVKypr7aSj4MlT2zMBdsvHY5DxU?=
 =?us-ascii?Q?4jaPqPpJUqv/lSEMER97Hn7iVyWbyzLnhUgg9PsItwEOHh9kzTn3OgL81hBC?=
 =?us-ascii?Q?V13YsB9Io5zKLnso/8PCF46+L9yAOmWVtxr29oAfJCKD9oNrVMz8+/RQQpe+?=
 =?us-ascii?Q?V7sTCbfmAWWqleoBqBszB6Z31x8sPtRzKqSSXN74vuiApJULGyMcTQ945HgY?=
 =?us-ascii?Q?0Crb5cI0lHaSaYn+t/mupJ4ioZrq7hkCyjfNrVA+BkzP4a4qsNdKN8A3pIyX?=
 =?us-ascii?Q?WRxVpOigWyX0g6iD3yLFsTjyu+85H+4+KcAIFHolmD9zIwoD7MMk5woqUzir?=
 =?us-ascii?Q?0iRzNzQmWXRA5kkfqr32KVcLoeOrrAPjnzq3vIqbKUkUs2/wPdIsH4whqvfU?=
 =?us-ascii?Q?Eg8VuNN4e97jdjiajPmVc1zq7VdBnnOinA3c+SuFO5Y7NVjKhRWP2RcXiQeI?=
 =?us-ascii?Q?stQH10jNJsjfjN6gggojKWTJnHAwJj2T3qmSgHQi1M/DRIr9Qb3JNdiR+I8o?=
 =?us-ascii?Q?AVWJ5Fpj5Xh30bh2VxlrYAGrxjo8cCeToVGKvSg9GLp4AUbE3umoXaBZtpbS?=
 =?us-ascii?Q?7YYvTlpQkXZimUivW8CrVWblFzBHAp04ebBdmSjwyA3hhbJwnFdMhDeqwzKM?=
 =?us-ascii?Q?2qyVry14YRSFP2Jsmgrm127VClkq3sNBS0JQu7zaFUlFJFujRhMwoJDgMqGV?=
 =?us-ascii?Q?UMiOYHM2rXI+njcnbWTWeB3ohECKiZTDsW3DW8eNNC/VdODPEsiJogxmGXvI?=
 =?us-ascii?Q?khcw3oIPvTf3pMpTo/xcmMv+Lc7T6LC2VzNWCes0IEj2Hc/k8RZiEfzlQJ5x?=
 =?us-ascii?Q?9OggGv2BtV+CHLr8usfALywScUdyQfRrW06MKCXILETqvnABmoe3N76E+Tt6?=
 =?us-ascii?Q?C31WS35mMA+JpiRdOhcqaKuCi9xbRpxJwqkTsSzmIdrMvs1LvFShFMW7xfsQ?=
 =?us-ascii?Q?jbK1NSzo8T7c+QKE6njOxGwgn0gs8E3hbvtprLJWWX0MhP+GF6wE/4TMEXv/?=
 =?us-ascii?Q?kZMb/rx9oKUpdfM79m5C0EGR+axMxxIIvyFIs8w7JwQonoZGMFZZziuS9v4v?=
 =?us-ascii?Q?pUl3r7FUvqj1h0RcEZAkx0jLPm0nhGSQDolJy9kCdJD0ECzJEa52WaxikWNn?=
 =?us-ascii?Q?c6Tl6jEqrAH/PWC9R6XVIU6KpG9Ct2xiks/BZnabtKddXGHae79UQXGMbAWh?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb31196-0bdb-4ded-5c5e-08dce7cbc32d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:02:31.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PX4L74xPodKJDI+GCN/Cl2o420qgl8iiOZVRkxYjH/zy2EzBK/WFCCRwwDeaaL/ufQldqGV16MFMMUWey7DmvoS0ZpM6uUzypIATv7PdrbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7597
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
[..]
> We have all tags and MAINTAINERS database. How do you know if those who
> are in the Cc list are really interested in receiving this? What make me
> sure is to have Author of the culprit commit, relevant mailing list and
> maintainers, also reviewers and testers, if any. All this information is
> available without Cc list. But if you *really* want it, you should
> follow the Link tag (for the new commits, for the past ~2+ years) and
> harvest it there. And actually I use that Link to reply to the thread
> directly. So, again, the Cc list in the commit message is a historical
> burden that consumes a lot of time and energy and should be gone in the
> future.

Andy, this debate is consuming more time and energy than any amount of
trimming Cc: lines from commits could save.
