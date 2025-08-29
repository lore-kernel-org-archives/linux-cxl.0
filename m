Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60A2AEFD
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449580; cv=fail; b=tq2Jf50MFcIFnNK0WSkp5Rsqdivm2FFCU7W0W3wkQ0FJGLprOWgulKQKE2L5Q8zvNvkwvSXv3mtNEybJlsEYbM3bEnSR6WjikHF9eiaRZ3g5PlS+jpxqsPMHFXpD4se/AIqmoTQQMdIzh5b0Ize1jeqRpLt6Byifao71r9R9+Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449580; c=relaxed/simple;
	bh=wgPHIkm81Zb8syLtgT1b3tDd20a+iuwYNc9KjLAyTi4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e4BYDWra+8q+716erG8BzfgXsw+sSLD246gpiN39Yh7fa9Y77Kaj0ttzLN0eilpD7MHN52ITdQ5OpAxNluck34X9530JdVhKHTsi8vAxjGjJR9fj7S4sq6QC/aQShzr37+PkoEWJwIRHzhD+earNyAuRJ+FkiOJAgZZhUV2MU48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXI3fJoB; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXI3fJoB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756449579; x=1787985579;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wgPHIkm81Zb8syLtgT1b3tDd20a+iuwYNc9KjLAyTi4=;
  b=bXI3fJoBZpkAOtqUypCLPFfe6+yVbeNkhBYBDVoF0ZJMTdKpj1ss5fQt
   B5jC0qiZ1vx5lvjn5vljW5MlB2a0RgcKgeavskU9QY+cJBGMv1Fl3XHSK
   gO/z/tBlro3ryTI7EBT+CmcYl5aPqWRa3DwGP+BBx7b8VJ8GOVbwp1X7j
   QIyUSp/N/NS0bDzKBChIRSTMR3GDl0563v5rTlJSozlvLANTNnQLMkYBN
   BMd9kkpGSAbe9BjhsGVSNAIP4//jNYh5g+Xoqk+u81mAdqq9hAbrO1YjU
   kk86nLHiLNk/mjXuY1CK+m7IFTVA9lSQwfsM8cX/+HBz7ai662seVKy68
   A==;
X-CSE-ConnectionGUID: AVELbQmeTv6Q214S+nbL1w==
X-CSE-MsgGUID: lbqD+u3nSBa6qvTe5EPIRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="57756680"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="57756680"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:39:39 -0700
X-CSE-ConnectionGUID: irtYYxEkQbWuJDfcO42kWQ==
X-CSE-MsgGUID: dQQV2xSKS7C0zRNUptFBFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170693957"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 23:39:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:39:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 23:39:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.77) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 23:39:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX6HdNQS4h5Hem/dcNO36A8/9xvbzlj8JnYZ3RmzLSKD+pfIW5uIa/TvfYfWuhIrDq5bwsJ8FydCy28KaaChaYa7sNV9xmKOfb51mejIfn0+3v9hf7zJWK1ChnXL53hmbV1/mI/MoGmAPt2F5trI3Wc0hxiYZBTCLxhY4A/SzX7otebTNbACt0+puv6eBcI7Mjqjco5jZ2q7mPKB7TlzOE02tzs0PUCtEIrLU24PFCgF0lJmmfieJuvkdRQ6XWotO2S6alvZVOrnDL77xfkFvnyP8Z083ahN2Kgj8trsEFQOMgixeZ4EVveUeANdntCU79ORvkhptNX3hjfrxwooyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvA1dSNzGWKYhYC32R7c1ADj+z9SaA4uh7BQEb3F5/o=;
 b=ejj8vOH0we3L1Ms6XGOq9BbePFH2lgFAZKt1tBmwR1JGrDJNZTDz+XbT8uMcBadcNLRCTedkVoo20WqFLBHhG+5j83Bse8ECp8qAnJDT9+E3ytK4nhmlUpL2N46MN3WDIOOq7VMPCz9HkFTwDhoProak8KXnu8y37EcnZyoxDcu2GMS36ddte8JSoZ/wzta+59ac97BrPUvQNOiRC/ygihPZaBOiX8mGwtU350NWXgcThyyjOgsSyWCkSQ8a2bjPODhhvMfUktEMC11OajOp4cKO4Fpvt5jpT3oKuorChpqNA1nye5bf+uo3NwKAttCr5zfFHTzXrofXcU1XzfI4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS4PPFDA9EFDFDB.namprd11.prod.outlook.com (2603:10b6:f:fc02::55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Fri, 29 Aug
 2025 06:39:31 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%7]) with mapi id 15.20.9052.023; Fri, 29 Aug 2025
 06:39:30 +0000
Date: Thu, 28 Aug 2025 23:39:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/acpi: Make the XOR calculations available for
 testing
Message-ID: <aLFLHmqM6MkersOG@aschofie-mobl2.lan>
References: <cover.1754291501.git.alison.schofield@intel.com>
 <e2ffaa6a29117fd9832542e4ac314b46ab2d1fd8.1754291501.git.alison.schofield@intel.com>
 <689bfe5a9815d_50ce1009b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <689bfe5a9815d_50ce1009b@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS4PPFDA9EFDFDB:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0a1d0e-9505-4ff4-9974-08dde6c6ce84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3dyX/MqB5gGUXjdZCTpN/Tu+jTB0e+Eab4dORpbh9WqyN4i9uAVJRZOO3/fu?=
 =?us-ascii?Q?7LItLSU62MQvGEOJopvrHV/jr+CzjOSO6kiFjUKJlJxnxk1TnINDTVpSr57U?=
 =?us-ascii?Q?T9Zo4kfVa2y7amSb96lKbrsZPNMRik7JmZ5WshH1zNVa5o0iRWbWQEAya2To?=
 =?us-ascii?Q?D3SWXB1ysslT6XGvFovPorPE+bSFSRALIHgnwIBG0lmAlXpTX3VvERYqBmV6?=
 =?us-ascii?Q?WbMJky5rZN/c76NLv/W6KVvTVWtcgaTvGvEDL/vE+DeqH+mebhJFuJxgq+iA?=
 =?us-ascii?Q?CPmk6fd/JrErpbmjqFsqWE1267eIF0klooYxsCsSphHT6RmKsuBFNXeLbyNO?=
 =?us-ascii?Q?4HCFpl4S6uJP7pCtHg+oC5B2/fcNTEWoibL8dIJfaJ8U9yzM3Xh1HrqILYTY?=
 =?us-ascii?Q?aSjQRdcVfk3Sx4vLGR1BJKh0nZlg5gnd4uE43GhS4FKBnXG5U0hbj9VXMtkA?=
 =?us-ascii?Q?Z/MOzDhJXApnxGh+7E64tIZ4fJ+W4/9cCYHWKhF6rZ4RjVgLG4D9CKySrJbC?=
 =?us-ascii?Q?tTurOwkplybWYtH64iSTLCa/YMe50nUZF2vCbVN4zvJdpTfSXJb1DwIpou0m?=
 =?us-ascii?Q?ZrALqIlhJ9iNQCoHWD8Diqds1ozfE9BA+irv3Il/gHK2cAHZC3rR+TQCn0uJ?=
 =?us-ascii?Q?naFYvLg8gg0GixlDfUpQEl2v8zHoVhySLg+1zDyr3iDmrgGTpwe6fR9duZXS?=
 =?us-ascii?Q?h7ck3jhmVsIBRhKZKlfCis9Qjr2X7tLVVTsB8OXLcRaAIbFS0HugAHhhWPDw?=
 =?us-ascii?Q?yQeCjX0VSQuJRjpn2JxFiey0quu5Cfuaric0IerD7jiYYuecAcIdF+qaSADU?=
 =?us-ascii?Q?rItygyQe/8m+kjyGBwzBF4bvoe7tW6lwA466kdLcBEmqied3y4fekEiRiAMn?=
 =?us-ascii?Q?NcCsoQUKGUReJhlKJwNusYxsQ4oVtwfuRcUi3VHSEhwsUqlfkezYBribbH6h?=
 =?us-ascii?Q?JeVQQ/tja8VG8vxD6dcgaL9XL6VI15/vtWQTeiVbgnnjbOeYOsixX4O+kyAZ?=
 =?us-ascii?Q?fR/ra7lxH6nxH2t/XBKisJB5/me07TJES8UtY0G9OAv7I/4m3ZX7Rwb9k9Jk?=
 =?us-ascii?Q?1hUIuToxCaMg2NRkNopzCrhTVCTcvc85bZd3hNHoM+HT58XTN3Fg073xh6CJ?=
 =?us-ascii?Q?f25D0WWGgHGPAO7KkWF9tfJ4BqMwQlp8To2zdw8wrIzCxfa4GINuucHq0Msp?=
 =?us-ascii?Q?Q8GuNao0SIa6Vc+UD4PGd6U+OK0/UDVTQEgNsfizhMo8yLgguyQuKmdQgAab?=
 =?us-ascii?Q?JflV0PSBJG20G0Cimrky300LFHZA+nwKxJ6eY7djKD24kYxcpUJiOzyED/8N?=
 =?us-ascii?Q?WH7isuBW4tEeae/b4Sfjdc2/wmwf0Mxm02GSsHF2qjfqhyTm80h00FidhYi4?=
 =?us-ascii?Q?CuaTVK7Cwm3ZKGK6YdTxh24zc4cdzBChNBnrKX9ubFylTsP+Xw3N4oxCNCEH?=
 =?us-ascii?Q?KqWTX76mHQA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ayGFG0pmAn8sEFBT0Gi1JkHIoM67f5/LuhAwoKW2vGf2CwdngoquarQhffO8?=
 =?us-ascii?Q?sdGoug0evjVnT9z4kxi22jFt7t5x9D3PfgTCEAnsLyiRv5neRC0Yo9pjjqQw?=
 =?us-ascii?Q?foAbiXG9Z/ntPUo3Q/aBkU1ZkstJNijchTZnXbtE+9HobH2i2mH4SZKhJALH?=
 =?us-ascii?Q?kpOGz1Fm3+2qRipM6uuEhgnsnxQ6KIpkrazbws5+W47mF33zqVGcrV0WfAdZ?=
 =?us-ascii?Q?aQNKJfXkxqt91P7kDEZiuxR9ASt8KxF+Mh/rXoPil8qjPwP9HWfOtsNwCGm3?=
 =?us-ascii?Q?OVPEx94kKoeWMMmSYcATbs3ZIp+nTmWNUdRBDZPEs03nU0kdx+gmNKb8bSL5?=
 =?us-ascii?Q?GhQ/xtP/S2d9+0IcbXcD1r66HytYlMJgW7fE16TqIZ7wJDWIeprkiS3nCp0H?=
 =?us-ascii?Q?1sO0uOtr+SW2ndXoDfj2t9F6OL/VctqNJfYGGA1oROnGLJSASb06VeDadlDX?=
 =?us-ascii?Q?7C99GzX57B99cLzDnF1+/kQWuMkfiQDN3HWVGqUjXMcL6cMFLx5uqQDBWyem?=
 =?us-ascii?Q?BUSV92aqXjJlyZjYA7W2FoZ+QMCk2+OOnxFKFusaLCPy2YlYBlGE72OXsInI?=
 =?us-ascii?Q?z89VYSSdZcKgtmvg4fEeYQ/UD+MmbgzpYVx9wTYmRTApBdaZRFLJ+HjBfVt2?=
 =?us-ascii?Q?Mf0LH1qarAGxY7w/wnllnalpu/Qs/kcIzvYxkvRSB2xGRm/yjrQCEVJNaom/?=
 =?us-ascii?Q?wtn/TeiU3yo4XudXwTMzUYyHpPJoT9zty5/Es8Tb3nsA5QbCTgnE+4kTARFO?=
 =?us-ascii?Q?2LMQDhL5EdcLUVmHHI20rj+2qda9AKFIfQJPbnfAR7MeOYa9+Km2Y7oUWNDC?=
 =?us-ascii?Q?HYvJ34pd2ajGdPREhMqMsMBfkU4+zhgq3qbjEgBTGapMiFLYTxtlqtxTpHRU?=
 =?us-ascii?Q?oX2HQghx1OZw3Sz458CICeEefJIXLiDEGm3xiqfTMjreCt0nQHH2IrLUX2/N?=
 =?us-ascii?Q?V1GOKRmFvxaSE/ZexN8KKM6TaGHim4NUf3QU+KmVPq2lVrygEYoDnebPRyKF?=
 =?us-ascii?Q?qyVFD8IvHvchgNlmNSNhAyrh+B+8HVa9ZDc7Ot7y6WfOHWbIYW9fnNUP6t1r?=
 =?us-ascii?Q?R6XPQcI5wr6B+adDo65nT94kNCaXQti3DdwtLqe25W3j5RLvIUfUJGE9El5B?=
 =?us-ascii?Q?sbP9jUAUMac6proiRqdt2QiPvd9nRSh9nD4+peDqkpbljbyFQ0lm5Nwckt8d?=
 =?us-ascii?Q?5Ws265ESpFzmCs1nTc7YJUOul0DENLmy/FTdcoG98CXXkhc5WT1UaI2P1IJ4?=
 =?us-ascii?Q?d8SvZkgF3n6hoD84Bg7yLgfiliQ0OrKQQxfaaYbjAgliXmVImbQr+YPVkauu?=
 =?us-ascii?Q?oF2eWT4a1gtkvLOcu4YgzUzZv2SAwrSkBoqOpBtHCDENsrniCkPAmpd4aqvr?=
 =?us-ascii?Q?IqtJjVCKT7C7RRw5xjhuarXIsW3a8hcuEa0lx3UFwPdQzApN44hS6itnz1Vt?=
 =?us-ascii?Q?dD3pGHw+GaEXI01be16xqOpHsAvyrDOsnPt/jZ5qAHLr5zrEftVGYMV32A1/?=
 =?us-ascii?Q?uxHOXBOIdHInnIHRlSp+MpgAYOZYl/b8G11U65CHsTaUvYEzpYc09U8pJY6I?=
 =?us-ascii?Q?CaiszyM1c5RxfuZpPmzZSfyu76dXoR4pxePh5efgM4NEntMDWzMbl8W2Xc/E?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0a1d0e-9505-4ff4-9974-08dde6c6ce84
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:39:30.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34g3wc0R7tOVFzrgX2bMLKFE68+yJjQBI887D2C2HWK7BN9iJ0czQXpJ+oYxdpDlwWAd7spcTUBk+qDOPpYUvy+Qd/O6cotkZpQGWyP4dR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDA9EFDFDB
X-OriginatorOrg: intel.com

On Tue, Aug 12, 2025 at 07:54:18PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > In preparation for adding a test module that can exercise the address
> > translation functions performed on XOR configured regions, the XOR
> > function needs to be refactored and the ability to create a CXIMS
> > provided.
> > 
> > Refactor the XOR function by extracting the core calculation into a
> > standalone function. Enhance the parameter validation since this new
> > function will be called from the test module where the parameters
> > may not be guaranteed valid.
> > 
> > To allow the test module to create a CXIMS without exposing the full
> > cxl_cxims_data structure, add new functions that can create and free
> > a CXIMS.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> [..]
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index f102c0fe3431..854578c6009f 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -1616,4 +1616,11 @@ static inline bool acpi_node_backed_by_real_pxm(int nid)
> >  }
> >  #endif
> >  
> > +#if IS_ENABLED(CONFIG_CXL_ACPI)
> > +struct cxl_cxims_data;
> > +void cxl_free_cxims_data(struct cxl_cxims_data *cximsd);
> 
> This just wraps kfree(), call kfree() directly.

Done.

> 
> > +struct cxl_cxims_data *cxl_create_cxims_data(int nr_maps, u64 *xormaps);
> 
> The only caller of this is cxl_test, it can just be copied there, no
> need for the core to carry it.
> 

Done. To make that work I moved "struct cxl_cxims_data" definition from
cxl/acpi.c to include/linux/acpi.h for module to access.


> > +u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw);
> 
> This function should be static outside of test builds. See __mock as an
> example of optionally marking the function as not static. Move the
> header declaration to tools/testing/cxl/ so that most readers can just
> assume this function is static.
> 
> That said, __mock is currently used to optionally mark a function as
> __weak, so maybe this wants a __mock_export for that purpose.

Added a __mock_export and used on all 4 funcs, with a new header 
tools/testing/cxl/cxl_test.h.  Please take a look in v2.


