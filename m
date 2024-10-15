Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3E1FC7D6
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002912; cv=fail; b=LdCIKmuRv8ronwzvU/XtS7Ld+lncFIShR9dSGB1tV2AIqHcgAe5H4akbJczQDBFXU7PAt6AxLWHh0ZefZU3JxAzXyZmTe8tIKkln86ayzlcfaOi+e0o28Hj9LLyvTBa+P3rGuGu0mDrtd0k32EUbsbx5gV1rzPLClgJki4GnJfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002912; c=relaxed/simple;
	bh=chB+y64VAT8Se1gd01huFp2X6k53teuhhJvGPRSKiOU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M32n95HpvH8yOYRZX3PbHRlGNcESi1mEpnILzraupqnrmzFJCU0xgaAOTy8CsSdKWryl6QilO9AZOYul3bo8U0ypuo4/I5Bo0XqDs5jOSPdW159qF/05CxVK11wZxlPZrxHJZmhBRnlpriCxAwvuZOUrphyBUnEd12HDsPvMNkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzgBfQV6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzgBfQV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729002911; x=1760538911;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=chB+y64VAT8Se1gd01huFp2X6k53teuhhJvGPRSKiOU=;
  b=bzgBfQV6ZjQXErh+weDvleu7aUVP1kjQPo7IPlVCwkmQ74rgtSFeHK/Y
   HH3JlzSFVQIrSsx0IpBXrdmhudCCnKz/e4BnWFyM3U9UaEWWcgCgFzL4h
   qALhJvWZYm52EIsITDlzUW8/jKSizYSLImogdcPb/kiSLsZjCogZGou/F
   qwjbErmc5Y8CIvQmwAj4Idq9QGIqTt4uhr9LxfcZsuuFC9wPn1d+dNibZ
   QoUvFyrKWhvNRgiA05+7bEl2K/zG1B4MQOE6FToCca5IAacrtsAZmHIld
   Ga5T0e3wBWeAmVODSK8v1nF0WzlREAl6O50EPepT++pd45LSeGX2Sjq7A
   A==;
X-CSE-ConnectionGUID: v5WpSI3ZQuymgcCCa7S+NQ==
X-CSE-MsgGUID: 1AjdIoEfSR2V48VDmF3pDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38952548"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="38952548"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:35:10 -0700
X-CSE-ConnectionGUID: CMZIzoeAQauq6j35b76Knw==
X-CSE-MsgGUID: HAYtBrOARHiGvzk3x00pUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="78091125"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 07:35:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 07:35:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 07:35:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 07:35:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 07:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxauYY5V1bZS9jpzg8vg7dYC73BIlxzfVsb243GePINMXx6Zcx0LjW3+CR4jXSHCGzXoE39KEnebcxj+w/IE0QWbYwXLGNIhqjFv7yDP9EeFhDqStCUp87iePUSAt6mYWfhRtBONn7Je/R7mB64aomcZ3m0s02ZujUAVmcysFK+ZI82lxMLyqFuIgi3rUu1AfPLNlMAaQI1+ILw0uKc02599c1d/enAhIFGEZIF+sQsGZ9aiYbmlxtGjm4sXfhxGEmbaBlDR7/FhdBVznmH7KgfGZVAp0rOaZlXRx431RR0i0bWi9ZWwJXoKuEgyv1nZs1yVdL90Kp2FQrcmISukSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0+/plXRiCq59bN7Y19Ry+Gp1y0DM+57HsWnBjw8AkM=;
 b=UrtDgJg5iSUhfRFwov6yU0YsMTpsGG9ghUaTPTKcAPJpzhRL0BNXgbfFxppYW9ngsFHbZCbza6gdgbAZPcNRwnrCKpYVFDIG9ZN4EC7RHnkJaO7YjSM+FT2p9zAE8fnzUq7N4DSM8KtZx7j/k4m59FZzjNHdyTEi155FNlqMiFFD/6qmqmHfmBKhEZtoqo/0eNsarWQscJRGENwkez4HUb58xkr2D5MWnAeR4zI+5tdb3ahpEURHSWsBgFK30e2W9B8yJkjGvZty8IuVMB6keaZU5GkQeWFLvjz89ZWsdoYSDj09xdgY33a1PmvurcpCqn3pitngyTG/N2pJuh1+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB6270.namprd11.prod.outlook.com (2603:10b6:8:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 14:35:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 14:35:00 +0000
Date: Tue, 15 Oct 2024 09:34:57 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, "Huang, Ying"
	<ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: KASAN error when insmod cxl_test
Message-ID: <670e7d9125fc0_156512294db@iweiny-mobl.notmuch>
References: <87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <670de32847e6d_3f1429473@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <670de32847e6d_3f1429473@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0306.namprd04.prod.outlook.com
 (2603:10b6:303:82::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: d01d1468-2e25-4e72-ed14-08dced268c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jh5Jal/TsGrBmai3iuUPam7CeFsoXz/gCIj6X1qhHfmi7FBrM9EU1NBu6lMh?=
 =?us-ascii?Q?ngYBd4E9f2+C0+A8/QzEmsHZQdBD7yWclPbp3a5BPDf+KbCdaMEr0xFQQUxl?=
 =?us-ascii?Q?xm0+VVKY71Th0KF38+TssLJjFaW4B8Ai206Wd3lu4646P9ELVrjQDRWKd0m3?=
 =?us-ascii?Q?3bVOarnAk+59BQMeRXcrCqiJ8mtsZTvYwI49hAMsCRgFOhdy0/rFAzSGy3Hx?=
 =?us-ascii?Q?DwfHPuEGWjBtSSSzDgmZtfJl9XLHcVUewgGUXGP15hHIj6GXPZlRA/LpOIzs?=
 =?us-ascii?Q?SHoepnAifaAohnJVkoErAf74qG3aOkxB2aAMG9HhmpzhuPjcdw212ZzT8qGa?=
 =?us-ascii?Q?RNIWDBV5HI/B+9mrWeil00UhiB9CN+BuKeeTEXLe3WyPb4SNsUopwz4/iY7J?=
 =?us-ascii?Q?ZGKUmjmeA0YaHWKXSa6lTSa+CAYz3PY9WTJCqfLw81cP1u93pa/0OgjxWMDj?=
 =?us-ascii?Q?PFZjJS/8sdnlH1FeihNfR9YieNF5I8L++juiv8lz7saVALr3bG2DwvHS3pfU?=
 =?us-ascii?Q?EeFZ4KQRe1zJEjnlqGqefUvpe2508dKmlLBAPAXpqYIK3Hg+uAGdMR5t+zAn?=
 =?us-ascii?Q?1ma+ykM1luq294eXCPmjVMRgjv8z5bp5n4+CZrIxq/Qmj8Dzp9fIORdPTNGE?=
 =?us-ascii?Q?WE8605hHa4xFwfRfCSmgmOFQBWdfPs1FJcQxCFuQsDDUqm4aFBqPAQvKMfg7?=
 =?us-ascii?Q?J76xuINmbjXS+N+4qjg6nGdiDCyrdXtEeBGU7FAiQSiRmsYb6ys9eL2jw9HG?=
 =?us-ascii?Q?aat5emgIDBZW4bXjlcEhks6vyIc4ILebR//v1GeDkYueAvppSLTXaqgd5C5g?=
 =?us-ascii?Q?/KD6Sw94MZdZi280e1PQIgG3azSqidZ0ea1pLHzodfETeOxk/6dG6OU4xaSO?=
 =?us-ascii?Q?BczukIp5y/LJ0IdX1vdJFRo+9GKeCaQBxl0JYHuPTT+8xpgQC2ptd7kvP/uA?=
 =?us-ascii?Q?ojRA4hfNTgVlJQnOy5P/dMvPCJcpxWMEHpC6W5E2apAgTPW9+Q8cGqt7Bdjo?=
 =?us-ascii?Q?ePfeTch52VA5+Oqj3O5oyIdTDEme1adCQ6hmxt7HG2Qaqv68IT5XDDkls0G0?=
 =?us-ascii?Q?vMd+fommDvO8a3TH4BDipun70i4QfzDH9l31a++32GqwcHLFe/yh6e2232WB?=
 =?us-ascii?Q?UmY6Q9QmmJ1+3EIRGYtmFexN/92lJrZeU70FPj1OKdh0hcTUoXfuCqQvejKF?=
 =?us-ascii?Q?o2b2u1cOH/2kQGZ90cfKjjbixtwqFHST2idpjySrKL/IvoFAOolKSkgShG9j?=
 =?us-ascii?Q?flY5KBSvtFm9E4e0CVNURSKJWw5yuNebbY6RQB/H8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aeMjyj7tK2HdGbkcINELJvCrZ2+OGLuwYtgI6TVuofnBgPHR1UrSUwlJJniu?=
 =?us-ascii?Q?+yoDXUjeLTVyX0//hVf0JORTlB0H/SEf3D+jWYSWYYM0VEfR3AQKGohNwmxP?=
 =?us-ascii?Q?Ap4HWIOtSf7vLZ0WlfnkHawGvyP82AzUbH2kStql5N/wJnrmTFUSLKZqf04A?=
 =?us-ascii?Q?Rf4tF/V9h/tr2XqrLUxYO0AXUQHJolmLLiAzgliIoVDR6jv88GKL4wfMwsLF?=
 =?us-ascii?Q?hj2NbQaa/FfG9o09XfueMCpym1PiSF1f07Ez5VUoyHWBIyjouOChQD+rfc/v?=
 =?us-ascii?Q?ZDvzwOeea1neXuOG8Auk3OmFhCFLbpMlJLYeC70ivIKAMRgPC8wprCoRHqXA?=
 =?us-ascii?Q?KeiEm7fC8yin3Wq/S42bo4+d+IV7o/5d23ZOKEd84L0hEWHRr3+8e8/Wm4V6?=
 =?us-ascii?Q?+54JQ6DG62BIz2mUZ40IsUL+9goKTG5+kJH8eDNxbRrFCEe8vCZgu+8BZT6v?=
 =?us-ascii?Q?g7lmhAPIeV8xd7ntzndyTey2XtZ3+zBmqWqdvMJG7If1zH5amTzgl2caPA8P?=
 =?us-ascii?Q?+vHX25EDPoxJpP37kfhSgp8FSHXMmWDnfyccDVYJ67OQJmjA4zglXL3DwmX4?=
 =?us-ascii?Q?AeXNEARtoUR2KabmS/g+pCGQjaYXat45HjXuuqSMz1lV7qtINlr279D76g/C?=
 =?us-ascii?Q?JR/iWCyYuR2ANDUZ/o9eSVehuR7V/K7xp1F96IvJYy3J/Od9bakT444XvP38?=
 =?us-ascii?Q?zdUunhKhauVHR2CztDQDWHNbkIK97gDatxYa01HhliYTUYttZ5DILT0T6wpW?=
 =?us-ascii?Q?+KZWk9zUehu3nYCVy9XoeDXC1FFvbV+qdsW9AyhHNoK9MLE8U2wsyPWtJ/wF?=
 =?us-ascii?Q?J5is/LSQuAYX9f7hnUelgA05+xMYKhJP5wlF0mpFbR7xY59/j3J9KsNVETgE?=
 =?us-ascii?Q?BJf2y344NEZfEExd0ojTiawB3HjnO4uS14Y2dIAYbDpkM+1SRVFBiXwtV76H?=
 =?us-ascii?Q?QjT2DZQS6pq0obQe7YzaAoLmwCmO7RNGbuJjN3nPB7GG5EDSC25rduy8qMXu?=
 =?us-ascii?Q?Gh/n5BKFlJ5HQb4mYKKX9RiI94exdeS4ocpcTwqZg5bk4yE0ieaJ3SYof1KJ?=
 =?us-ascii?Q?qgCPHoDIjZbV8ZnjgPae/AnLAZh+rsRv0NGDbqCdPWLEfkJqCWyCX8NGP3Ss?=
 =?us-ascii?Q?PY74lVUJlbTnzU1j2kduttKl7UdesK6r5R1XOZo8U9kT8ZjnRHbUrpsX10v6?=
 =?us-ascii?Q?CpP3I5vn7G4U09rg65S60BY774Hui+rUffPzZ3k3usYUnGy6PsOuQlOcZQWk?=
 =?us-ascii?Q?tyvZxL9ba5LOGyfjZPgSjAFS8u2XJt/9bk5xpfHusTBcuyPr4/o9yf3yG9vQ?=
 =?us-ascii?Q?UPGxE17zF5BZjQPEF047oejUq1c33ywu0qyymyppuc9+qXTls1AJEUjYEa5R?=
 =?us-ascii?Q?a7Div3MTb2i+aQM+h933D6QR57PwFjngRkLpSlXfVCGpUjXSe872ZQljWWk6?=
 =?us-ascii?Q?6m/8+41MNm6pMwdHWiaZpd0npY1AhqBFyQJrd5OZeUlRvON3PWh4u/P8j3ms?=
 =?us-ascii?Q?yW9jveI6T2eFkTgSSYiefMBX+GJJDwtAKeAfFAOdMWjnpxEdxM4hu+7KVXgk?=
 =?us-ascii?Q?nBfcBY/0jS9BAS5QrTfk7eVn4tnlqAQ7BoyKGicf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d01d1468-2e25-4e72-ed14-08dced268c87
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 14:35:00.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmP6BU5TW8g0PvtoltH0fbsA8BhWgpKcGWa8zCdf/cUpWj+VW+e+zA/5fsuJ6YX+HcIo8/Bje/kdE5q25r7Dxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6270
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Huang, Ying wrote:
> > Hi, Dave,
> > 
> > When I tried to test v6.12-rc2 with cxl_test in qemu, the below error is
> > reported.  Revert commit a5ab0de0ebaa ("cxl: Calculate region bandwidth
> > of targets with shared upstream link") can eliminate the error.
> > 
> > Can you take a look at it?
> 
> Does the same reproduce with "modprobe cxl_test"? I worry that direct
> 'insmod' usage results in cases where it proceeds with the wrong
> dependencies. I.e. I never test with insmod, only modprobe, and my
> v6.12-rc2 testing so far has not hit this.
> 

For me this is only happening when I boot qemu.  I don't see this error
when I use modprobe or insmod after boot.

It only happens when I use cxl_test and not qemu test devices.  Which
means Zhijian is probably the best solution.  I'm testing his mock diff
now.

Ira
