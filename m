Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D517C200;
	Mon, 21 Oct 2024 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729481773; cv=fail; b=dflk+o12zUEuIHvtMuLZS8lhdmunH4p8fdvvC97MwQsAM0obOSvNvRuQ5v/Jqj3m5MOudsYj9uNq92Guk1DFEBwhc3PjMjUzGeACGVRDeuKhlY3cRh2jkPKda3zwsIiILKY/8raMo3H9Ff74CYhcv1gyIfx4izZPUrykNoxuvbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729481773; c=relaxed/simple;
	bh=12iiOS9l8E63drrFckNdxAvB1VmWbLP7Tu8C2Mb+JjE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uDy8rkYGOrEn4b7qGPxr10V/GIwQbjwTksf4urFWl1O/LHIAIh9jYGRa4DHCki2eMUE5e42pTJ7Ap070TZB1L/g3u7NeL55ktD7v/171bH/tC4Z2iFxYaMCvhOhEOFHZIYAc82flKuyhwa2qqhMgRT6aEwM6h9UjxvaIsPeNCaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWl+gGH4; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWl+gGH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729481769; x=1761017769;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=12iiOS9l8E63drrFckNdxAvB1VmWbLP7Tu8C2Mb+JjE=;
  b=YWl+gGH41ZvpMPS9Fw+CNPfhKZrdb41m95aZpBUrsPnB9M+lFE7fejd1
   RAK1Aqhikyxy5/UaGUYHNWmTKomnqaof8kud2ft8M0yfH5+LZLjOPBaMv
   yz/ABvolFsLKXc1F5ekX+RvmcTsCqnjnATGAO48Lf6GCMffyWEM9RR7bP
   j2VVOMC1/7+lppaBTRpBLHbJBAwRAX/mQ3Aoh7uih+N9GTGl3N2cs/DBL
   kIEhlziyMT9Kiob0Vh6D3W8gBJFVe+zj9OdsyqKKlxlyQ7U4uBV7F45/S
   dGrsTnqRxTLh+TxB+4GqZcAaS3iVs5jXoD7yYKxEb7EQ1aSwLVhb014qQ
   g==;
X-CSE-ConnectionGUID: VtwOND4kQB++ML6q8Yuclg==
X-CSE-MsgGUID: C6mRLlNySsq6/G0dEfEwTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28899697"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28899697"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 20:36:08 -0700
X-CSE-ConnectionGUID: aPqKJAu6RNq0FSohUIA1gA==
X-CSE-MsgGUID: xL76iRKGTh+6qSJKqRW8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="78996017"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2024 20:36:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 20 Oct 2024 20:36:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 20 Oct 2024 20:36:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 20 Oct 2024 20:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JW9BjFWN5g+ByV80jzRl1CYBzW3ftebZ7FrbPSp4020MyFhNos5wZ7d3DgNXv4KE2h09U3rnfS7bmUemycJfHloiz4i13FFWSP7DBx172DOQxOaqQ13WJK8BS4n9c0EjjPzN7pDVKFzLS0+qx3njvHPANPfHOBjgYq4i9BHqLoXm9F1L7KYNW0RriSeTZACB8C1VYtK7boEvNNcjaXkS1U5IL3Gyp5ndwkFeZpvbuS1AmuUuXXP+UG3fLF+gjsl9eO238XM8M26Fb9okcltZ6GNH23XzzHYXM+qJ8MunS3O6ZcY6UGFFLNvyXa/MAvCOK7bU8gXRC7cWe0hR8egu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlvATILJPrUMFIR6Uwy+Or3+4B5e/hzaYDLERxWuIjA=;
 b=hqiDZ7YfXCCcNVeqCRmK7fOQxiLLZyqHPW80uU6nhrfmNfEAryLXDfpIle396CGgIdvWOiJ0h1qH2H8lFboxgVB7+sbevaPpZduX03nhHYQ2uQuYx8DmNTKQTRBJCL765EpRQHJHGKO3w4hIATizJrwrHPuAQpNHwQka9wg5XGS6rCfgJaDkD4eV4TqBNO58oCtTgMdMCw+SR/f6dZ0tGHBRa6N14cvVNiybT2JCl8KRLgnh5Q/tptvT1h7fApkzy9lZZoG/meTNfcwGfwOjaORHjdAEhtguOT3zSrKC0XjoZSA63r2M1Dg5HNueJ3+t70jOGmbF7ChIGISVjFG25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 03:36:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 03:36:05 +0000
Date: Sun, 20 Oct 2024 22:35:59 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Dan Williams" <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] testing/cxl: Fix abused pci_bus_read_config_word() on
 platform device
Message-ID: <6715cc1fab7ec_747d629455@iweiny-mobl.notmuch>
References: <20241016015213.900985-1-lizhijian@fujitsu.com>
 <ZxGqYPGNaVWoLuP6@aschofie-mobl2.lan>
 <6711b7c0c0b53_3ee2294a6@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6711b7c0c0b53_3ee2294a6@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:303:dd::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: b522c668-5d31-483e-506d-08dcf1817e49
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xMbWm2+1IAJNP9q52vtaE5Gj6gbnNDsAJjOmL1ygO71zkW7tkqlF4eNpf0K4?=
 =?us-ascii?Q?X7OfCqDd7LlXdn9YQ8VGkUmsjMFwhUNqS4d5Y++lDiQhgWzd+5MSNjhs/u6Q?=
 =?us-ascii?Q?8GgwtQmHqagcWg9Wih5yqSGcS6iubZ8aDVmqQQhXo1mD2F9u7ZIdhpQLDT7y?=
 =?us-ascii?Q?Yi35ahmTc3cKmre9IIEXwWQs/eRlgafG/2OxOWmOhVvzP82AcEJAQKFPyOYZ?=
 =?us-ascii?Q?A+LvhkNCImEa7XOP0q+onJ1Tc9faDXvkX5mcTl3g39QgIBZNH1z5lTPT+CWq?=
 =?us-ascii?Q?vM9QWX8fPKChGL/4D42miGZqaUwfyS8lczOjxiSOymcZEPkBcmbSfpbGMlXK?=
 =?us-ascii?Q?Va6/eI7kj6LLxDI1meFyZCMP9sP8Ad05wxHomYu3+N5t+PawJtVeI+KgAqAn?=
 =?us-ascii?Q?ZnfSmQnmirED/1sdSDUgYT2qO6KY+QkvYHwwal+oQqjujlsbR3be2q3c0qqO?=
 =?us-ascii?Q?c2t4Gxx2lShVuOxNu12PLA7k5nR78qfgYkAgZ+xgjkeZYXMgvqdESKqeAHSo?=
 =?us-ascii?Q?1fPBxHJF6BSGfHkeNZu4C7eubh8MbP0S782J/wSILOaZYEcJnTaExORat+c7?=
 =?us-ascii?Q?qqF4hcsG1teI/SyP2+X6acWaAMWUs+SRrzjXNtlY++VnnbrAaDJ677HDFu/z?=
 =?us-ascii?Q?Ehnjw9MKql2RsPRQSMoctTOWOd5mHq8mw62AnE0T4W42AdoMVgm8k6elxYeI?=
 =?us-ascii?Q?gJzcYRiKF1unePHm1rVECkSvmZl82qRujLyIuJRKi7iSxV/um3hBqxo0bXxZ?=
 =?us-ascii?Q?YXs0vbYm+pL1e/5lrKXRxwcFfSPq7TRzIipLyiEH89NRjco01JMYV1OhAIsP?=
 =?us-ascii?Q?t1zp/xf6LHMqGB2drUk0fLiIq4EpqXGm8LUOsZnTffjXihG8G76uhDkxZK6M?=
 =?us-ascii?Q?AJ8ICTKZQhPYJjFgf5aDkmLktvk4S96PcaFwORluOUKmIEaPYo+jqjCl+4Ik?=
 =?us-ascii?Q?rLiCe08E4Rfxb0CrO3xsOGHkA4UyWYlSiksWvp5iZgHy3CUY/DF3OQ97qDWy?=
 =?us-ascii?Q?ow0ySdPhGXQq7ZOF44FqUgRUiGwQbOFVi+3Ts4uPaMXgcVP++W0UPXS+10Bs?=
 =?us-ascii?Q?5Q4oBPozyOhRuu7YTA6Td0QMkdL7/dXQPbM1tFUSEsi8zucR/wm6nm1BQtZ6?=
 =?us-ascii?Q?3yjL70PSA7KVJiY+DyxxgFXKIbR9bgZxC7XRankLMNKK0HYAUaFI067xcsD7?=
 =?us-ascii?Q?RKFtaKP9CPj88RsRQDZjTRyeW9KgFi5opzbKDbKmxq2XWzk9jwbfZnbYEbK4?=
 =?us-ascii?Q?zadAUTpn3aSJwbTLrQLfsRaCcF7tSUhyCXZpwIcrnX7Qan1YPBEbfTCVk4DL?=
 =?us-ascii?Q?Soc9ZcbPGY+FoJLhRIvtNXgl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1GwUARP+UsHW5M9Ews+09GYFQrL5lP8DKFSxt4KhI71UyzpeNLYFTk4yIHhc?=
 =?us-ascii?Q?ngakbTBLFe1UIOlyZ4C/GTW2MJRxdOQwiQX4U1KDKSDusVheh3aAvohbyJ9h?=
 =?us-ascii?Q?WSZbS/6Uz14ThDcA+dnVUkcPm7ZEDHao9u6E4Zb7dWYxka8sPnTgiaLqnazH?=
 =?us-ascii?Q?V1nfFf4HBheO7cGMuS0RIGN/MaI6PaQoKCB99i21l1nQJ79XM70lAcfM7kvi?=
 =?us-ascii?Q?Xr/PWvpQ7aRq11SSGfnSBeXhnsJxOrnvGW4C7a19ffcE/EHXJoFPESCxmaVn?=
 =?us-ascii?Q?pD4SJU9pRwrCy49TOXFpWzd48LfuUk3T0XJomOK5yZLZqSKkVXp+bKAsoO5l?=
 =?us-ascii?Q?yG/l04xx8fODG4+ks4VKV/aoCSv3tHuqLy5hbx3hzsCK8qGo9Ivi/bXnCic1?=
 =?us-ascii?Q?DZPni4DkzdvVdVzpdTSyu9tZPw5a5Pp8GC+JlB9rb8y+oBRTqMWPyb6XwWxe?=
 =?us-ascii?Q?5KwTd4EAlPvc7ZmWrAaAzi1MxlKQgXDCuY/coeUtPltIB6Z07D2GTcCC4C+J?=
 =?us-ascii?Q?ghDIdhE+2+2RrsJxR22ARMVVwPIceOZ6lgW+lOApCs81tW6iGdh2e8rV4HH3?=
 =?us-ascii?Q?kEGaGfyNvdpQKobXyObQRUvUHyUTYTjQWAcOqu9ZA9RqjHJZ4zxjjHyhfaCV?=
 =?us-ascii?Q?Q2jEQ0bkX9iSRPGdsg6MNSgjyzktXtVBwPblabHbkD8fpLJNlUBr+eA0oECe?=
 =?us-ascii?Q?371bBwwrgqnQIsVMVykAtdsZbXNMe0WZCGaThIAiuXAVD/eBeg61xpJUhr3U?=
 =?us-ascii?Q?u8NH+9owcYKWD5dqgsbZgd/YAJ0tcrCppxLZjb6DEzXknf/njD5BPmvoCJfV?=
 =?us-ascii?Q?4VmGMt5j/PnleVW4H+PedlvllWkrzclaKLvQtz7ySk0p0odgjOzeqW5ATQFn?=
 =?us-ascii?Q?jjnIrT2epeuIXLCynf734x3TPMr3J4SOKy+J0iJ/JGw/FMzXJY5pCSAwpZDF?=
 =?us-ascii?Q?GJdDBkol219b5RXxPKiytbh9zmi2ohAe3j2badFWcB25yq5mxxrTQguHRRXj?=
 =?us-ascii?Q?EYuTmCSWSj8XUYWIBCqD/aDjvNeEEZ37vnHJ6S3Susm84J14dNAECErJFLj4?=
 =?us-ascii?Q?8xImnrMwz3p/JrOu53IqJrJQE0DacotQMSDjMqxqoE7pLkdtCqtcZdrajcSu?=
 =?us-ascii?Q?JTjUtdBfifTub9wgf7jNKpiEMnjvpgaScvEltJ8nHNHtdzHv5og82ykzDclp?=
 =?us-ascii?Q?haTupE9gUHGwvQvvOjl0urfU8lyTbNyNbpZtZF0CRW2OH1Opct8qg4zrIxl8?=
 =?us-ascii?Q?sy6MsmFTQvIVVQ7uh8r5f37KPr/THCOs6yjIkSDAbuuDHccyqMV3RsH5j+Qm?=
 =?us-ascii?Q?lUOBGFN7WREFmqAabOxQsTzhs7q8khyaT4jmlw2KzhROkzP/iS6JNwLs1not?=
 =?us-ascii?Q?XreySwiTYzx/KRRhW8e4DiIChKFQvxmojE7KyIxbfzpIDpxzLiPuJ3WWH5eo?=
 =?us-ascii?Q?T66vqbmsZP4A+B2xF/OL8Riz7vErkijWQXRO7VRjTuJ7f7RfZ2cPlcKlAQ8Y?=
 =?us-ascii?Q?iYFS1w8X7dlpUEp7tKyeotapEW4u49AFX8Ynp2OSSmQfq0ANNCgscmycF/ZP?=
 =?us-ascii?Q?CgeEqHZ4yl003SYZTwzRmesDv4Zv6IalybyK+Iku?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b522c668-5d31-483e-506d-08dcf1817e49
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 03:36:05.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5v27w2cNsnSROcpLfPcJB5WChDDDaC1jXvVnNXtn1dGBwdJcDz0M1vM6kUc8PgCvo8hLShdEc2Fsg76JnboUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Alison Schofield wrote:
> > On Wed, Oct 16, 2024 at 09:52:13AM +0800, Li Zhijian wrote:
> > > The cxl_region_shared_upstream_bandwidth_update() in clx_core works on
> > > PCI/PCIe CXL device only while cxl_test was implemeneted by platform
> > > device.
> > > 
> > > Mock a cxl_region_shared_upstream_bandwidth_update() which does nothing
> > > for cxl_core so that the cxl_test goes well.
> > > 
> > > Abuse cxl_region_shared_upstream_bandwidth_update() on platform device
> > > will cause a kernel panic with calltrace:
> > 
> > snip
> > 
> > > ---
> > >  tools/testing/cxl/Kbuild      | 2 ++
> > >  tools/testing/cxl/mock_cdat.c | 8 ++++++++
> > >  2 files changed, 10 insertions(+)
> > >  create mode 100644 tools/testing/cxl/mock_cdat.c
> > > 
> > > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > > index b1256fee3567..ed9f50dee3f5 100644
> > > --- a/tools/testing/cxl/Kbuild
> > > +++ b/tools/testing/cxl/Kbuild
> > > @@ -15,6 +15,7 @@ ldflags-y += --wrap=devm_cxl_add_rch_dport
> > >  ldflags-y += --wrap=cxl_rcd_component_reg_phys
> > >  ldflags-y += --wrap=cxl_endpoint_parse_cdat
> > >  ldflags-y += --wrap=cxl_dport_init_ras_reporting
> > > +ldflags-y += --wrap=cxl_region_shared_upstream_bandwidth_update
> > >  
> > >  DRIVERS := ../../../drivers
> > >  CXL_SRC := $(DRIVERS)/cxl
> > > @@ -61,6 +62,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
> > >  cxl_core-y += $(CXL_CORE_SRC)/hdm.o
> > >  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
> > >  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
> > > +cxl_core-y += mock_cdat.o
> > >  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
> > >  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
> > >  cxl_core-y += config_check.o
> > > diff --git a/tools/testing/cxl/mock_cdat.c b/tools/testing/cxl/mock_cdat.c
> > > new file mode 100644
> > > index 000000000000..99974153b3f6
> > > --- /dev/null
> > > +++ b/tools/testing/cxl/mock_cdat.c
> > > @@ -0,0 +1,8 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (c) 2024 FUJITSU LIMITED. All rights reserved. */
> > > +
> > > +#include <cxl.h>
> > > +
> > > +void __wrap_cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
> > > +{
> > > +}
> > 
> > The addition of file mock_cdat.c made me wonder why this wrapper couldn't join
> > all the other __wrap's defined in test/mock.c. I tried, as you probably did,
> > and see the circular dependency. I mention it here in case anyone else has a
> > way to simplify this.
> 
> Yeah, unfortunately symbols can only be mocked across EXPORT_SYMBOL()
> boundaries, but since the caller of this is internal to the CXL core it
> is not amenable to the wrap approach.
> 
> So, unfortunately what this patch does is break the expectation that
> cxl_test can live alongside and not regress any production flows. I.e.
> what this patch does is replace 
> cxl_region_shared_upstream_bandwidth_update() for all use cases, not
> just platform devices.
> 
> Compare that to tools/testing/cxl/test/mock.c which arranges for all the
> mocked use cases to call back into the real routines in the real device
> case.
> 
> Given that I think this puts the device type check back in play.
> 
> However, instead of checking "dev_is_platform()" check "dev_is_pci()" to
> be consistent with all the other CXL core internal functions that exit
> early when passed cxl_test devices.

Zhijian,

Looks like we will need a spin of this fix.  Do you have time to do that?

Ira
