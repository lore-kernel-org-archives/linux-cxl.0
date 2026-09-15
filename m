Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8881370D4F
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503717; cv=fail; b=NMjvAunxEtFZZzZHMuZeT9njgGX0h5LZ9lU5Ce4BxEgZXjm7uFZuviKZvMHgyIyEESM00Wg4GoyOlRhvKLtulieWGM7sPUbNKqabXvAvOnMazPevWRJ5XpVnip1vNQH/cydwO34RB+qCzF7MXkIUxh8crDN33lxNJPq+Jxk/rGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503717; c=relaxed/simple;
	bh=UpZFQvvo0h+ezcBgSrzr+si4jYkM9iDwwvQ55+pbOLQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I8URTzUDxLAhUMivnD1W/R18YJLXIqfjAa/QvQ7GBYSNxJWDSz7ByK5JCR8LCRdD2rgScy1G5OD0QnQQtK5BdAzTIiNVKqQwywfmJ9x7hrtlt8+YynKNR6JMDZqxFLq/o8cXKq5LFjGhFXMfl7zuUsJXi96gRb2acwfWN4IaK6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWLmu0sz; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWLmu0sz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789503715; x=1821039715;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UpZFQvvo0h+ezcBgSrzr+si4jYkM9iDwwvQ55+pbOLQ=;
  b=LWLmu0szFKIIEOjijwDJ81G9FEVcQyUm2NlmCdM36+VLEFzN+yQRZM+n
   NDjvW8yHkXqU2Bon4zxdaMPR2Ot6B0ePo1enk3AtpAuqlNmIqfL83XNp6
   MMWNq0W1wKe9WXhPeED5FSrC0wc9Hg0ZR4smrmSPbj0CCIW8mKwpZrlnM
   +2biJ0q+MvxF26LGS3+gfMmSbr8anlh5mSTz2hYvrHUlEzJeJU168c4V7
   LyJLPi2cHDLPlhZUwaniiNpyIIPEONC79/x6kYHgNQM5Inecl4iYEIX+i
   CpDrkuZPyUqNWjEgSBmintawUQAhvJdVctQKGBob6cGU2uYIW8BpPC/fy
   w==;
X-CSE-ConnectionGUID: obyoshalQGGmju0amIBdLQ==
X-CSE-MsgGUID: xzA3uLNnSMeNq6iH7Mz1vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89903264"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89903264"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 13:21:55 -0700
X-CSE-ConnectionGUID: Bd+8QSIsQVuoYiLldBXtHw==
X-CSE-MsgGUID: oLieyppkQAqb97kZZuK/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273088152"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 13:21:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 13:21:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 13:21:54 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 13:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWVn4onH8wq+M+0Fd/8pkfpXWxwtDkyoggV9NIyTlJ97PpWeR/46manuR04BeeXjOcibL0CYNcW1AdPxeixc6yps3BS6/oK7I/iaTqnytTahcHnpt562lyy7bD19sjoREO8A+gGLqzC01FIsgmcEDxPNaSf8ehLH79+NAc+rV6cMc4/pt45VaKCwLoDZI7m1DaN9F0BoR2bYYfO4rl5Rqmg9X/TNOUJFhog3UYa9I2YczEVwKYAK1n57cpCtYzbpMX7yMaUqbzdvqneRGGZl/Xr9m2s3GKbynIYH3ncindo8iUycwZGxYsPoKnr2r6jacoabF0aAka3MHJMB3ajtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9bvVomq8KiSl5in6ugJBVFDdFPmrd6kztRtJ7Kk7XY=;
 b=tH9jY+bA+fQLKnJRoLFrnTKllDT012zgse9SgQxSreoVxp9jTxCW98F0Za3E35TrvegrkZUSClPygpX4iDQSHKwr6iduAQ5q3ADyWkjP5140uvMP0tfSulam40M4fghxFp1o32pC2z3/W86JKJl11lkMZXaTkElp2xhOEJaMZmDn+6dNTbZ4+ManGu1yomScL6RGQQtCv1D3MP8Oy5g8EzH6hPNd2ooNfT1U0UIwaRr/nJet0IY1CvqheOuPUWbq+tViYAVoKxZiQRaQ8zZ7RA22kPWQWp0srY4Wbeo+DIjXUjHykzd0Hc43BRVzvlKFE0Qb9LKLqJvl4ZMmT3SOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB8260.namprd11.prod.outlook.com (2603:10b6:510:1c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 20:21:50 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 20:21:49 +0000
Date: Tue, 15 Sep 2026 13:21:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>, <linux-cxl@vger.kernel.org>,
	<driver-core@lists.linux.dev>
Subject: Re: [PATCH v3 2/2] cxl/memdev: Fix deadlock between poison debugfs
 and cxl_mem unbind
Message-ID: <aqmoulHGkQR8sWJx@aschofie-mobl2.lan>
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
 <20260910094017.4032170-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260910094017.4032170-3-kanie@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 6180ba30-719f-44be-4aa2-08df1366f87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: YUv0j4HSWEhOJGcn23eyCz1m+cOlXOxiaYQU4i/ZagR+GnYKXqI0PvdMNsQlzOYGDqmEqoVdUq+1E60Ud8jY9q2yI9Va+gfFK+k2kVMBK3ZfpB5SKjctZZdwPbDcoKfIvuMe2zFefAaITV2qbJyjgBAoiXF6l5AvFikYuLWBPd6T2vfgVPine9jISFrxaIP1Th3VnhfdoG8DeYjDKxIZdeJHzo8HSZEPa1Zc7nE3boh4JpMKPgnQqxlK3VR8nra6t7EkqDfu3WOMS8fBNiYEdC5Ifu1MtWcLLA4KrHzmZVAE3XkrgMMAfF6opmSHKwH1gsQW0Yp+UR9OwT3fy6c8kwJ0wWO5i1bMeAKv2nOjupgbn8IIlHPCkrJbBqPC8AF6qEKuu6EIdRdyI4fpi42awHO1qxB56iveKwNU/iu/IKS7t1TLqwlkEb7XQSSHnc0M9VBnE1eSUQ9e99MiTGiwINVGShe24pkW8deDvZDsBdcPgucdK+ucS7lcfy3jElTK4t/cPxXHmXev+fAVQliDvmmSRzgqIjGhrRVIzDTaowQ8iBJjrFnPlwAdTXKx3nknsS4ga6yl3aqtGNimG0jWpjSY5RbJa3Cbple9Bt9SptcBmKI0yZRU0keRx9yZ/6J8eowyHBqFuoGkZuZuFJ30xPB3EmAwudMwApiZbi/oL/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ri9q+UMhLSOg/qFHxC0RKxlj2YD65KfaX7vwbo0mUAyHuz8aANnSU6XnThRw?=
 =?us-ascii?Q?pjeGhe6ax97z3A2/mlavUih+AMFtPNM0WbvzAUt6+MVl65DZloNYXPiN0Okv?=
 =?us-ascii?Q?BEUBAfnmI+BPC4JR8rue8+c526RHcklxsfQWWPaHE4QPs8FW+NmzLkZapOR9?=
 =?us-ascii?Q?cxFgO9oAqqAgqh4dF73/4QTXI5MjbjEXhqd3jVTB6oKv8IU42RmHV5g0pCnA?=
 =?us-ascii?Q?iKqdH3jmO/0z04cl5QH3ly6yZ5t3Jf/1LFjwn6vUtuivX48dK8wb2rO3E1az?=
 =?us-ascii?Q?XYOSd0o1xvW240I8y/BRUGbzijfkpssMT1WqGAJKkaY2F8ct5yLGhpqIuJyb?=
 =?us-ascii?Q?pHG1S1tPm9W0KfldOnIzAWbuNB1Na9/8wfh/ySweTDbEGvW3fG6n5D02a1OI?=
 =?us-ascii?Q?4NPLJaclKEHaz/xUqm28R7ykGwwsZApcWkOSeBQ8OLtt8YE8OP7QI9RpzWem?=
 =?us-ascii?Q?SZkhmQEoWRsxASwqdAuNL02TBeMwAG8xpDHZXX90Xt8nvGqsggiZB6mzrc5s?=
 =?us-ascii?Q?ZezDYmJ0QQlMa/uTp0b/wyh7ezu+HNXHsvY3HBRsvCAoZEcHgujzDTYmIred?=
 =?us-ascii?Q?wLJBj9x4q8bmleukcAx3W521IyjaZJK5kk2NvKXbMB0C76OkLdw+wYB+nWWA?=
 =?us-ascii?Q?zDoOXQNfmLSQDMhZ2gFJHv5a6zRjoIOV43Xdk/BDWmhivJCt7u4fnGoAQh/p?=
 =?us-ascii?Q?qqYwloKS9vFxo9Y62I4luoheFRoIgp56FTk/7iJ4cGrAwoMhx9uB6D/mWCRu?=
 =?us-ascii?Q?STtsFsh8Zy1rw4xNlIFKlE3o0uZKrvd00pcItn7CggH+aNwnD3Z5xH94HHyF?=
 =?us-ascii?Q?6FK7IZXOYFHasZ+/CzCBIrLlRtfWo7QaGTb/nwNsSfS1cdXc+OwhGYCRFJ9u?=
 =?us-ascii?Q?7oJqt55ETZ2qYb4nt9XJ3sMvZXJ4nTN2wegZcbHVPraBD2lo7+EBUWB3o1r/?=
 =?us-ascii?Q?mAiK+4jZV+gsvSyB373DhN2ENOQXFG//1dkrnypRxmuyx3QNIEXoAzjncEvH?=
 =?us-ascii?Q?nbj5Cv3qm3JKmOZNgVZDbtqy/dluRx9rTuSQ9EmH1e7PahRvNBWC3RDk+onQ?=
 =?us-ascii?Q?btc7fjw0Yew0jm6jWunor2e4zA1BTU51Xk7hUDcTOxGGwuJwrCjD7gvgQhLL?=
 =?us-ascii?Q?0QYVQZdOhFGVw3yW6kLvYQOnHVPcOK2vKrrLWaimhR0hFfUVb34DwYisqS/M?=
 =?us-ascii?Q?fB/H2P2lepoxepBcHuBOFqP6ho+9YDNmJkgPOwNNt1/hmTJZlnzXIodbRtF1?=
 =?us-ascii?Q?YASgdklqcFwnFEpGXqfb0E9P+jrgPJ8Xp2K5uUd448xI15KhA6lf43HzzmJS?=
 =?us-ascii?Q?A71pLD2/PXi0oQI5wrv4sstFaWs40rcLp+c+V5gf4d74BN3dEYRhgYhE1To9?=
 =?us-ascii?Q?j17JaDE0pvdedKNfR4eH0pnZYiBUKYC8xwJPHU4Yth/k97ekdRtZIdqtr2OQ?=
 =?us-ascii?Q?dxSLAoBVfS3QSdu7RKB40pm+mcO5G6/lBWDUEH8bl1tgGmepUp3ruBaEi4Ga?=
 =?us-ascii?Q?4OOPFDV95J73TxzL2jhGIfTMM1xMou2Agyj56w0pnNhEZY1Aa4IpakcuATQ/?=
 =?us-ascii?Q?ZIJpUXFp+R+UhCc1PeC/P/g+qIYSokM3+ykf0uh6urRx8aJ7cTV71yPPJIOO?=
 =?us-ascii?Q?S9CFalMKGdoSKdJy4SVdbnVIlT24L6V8/usSFCHlG2lLT9i+9pl5Wpwe2gvT?=
 =?us-ascii?Q?1QYnYwW0pelkZJdU4eWNx/N9UeYN9qlAeIMS75G9S1x4Zjv4B2UhIOI0I/RW?=
 =?us-ascii?Q?J90mmrRvcZg4lW3JDHQUHI92ScvPBks=3D?=
X-Exchange-RoutingPolicyChecked: uxZMl4PPUliMaKJr0lda2C+rvG9bBE6B1QNK0H/Q6xKkHPC+NthZ1Um3syIDU3impa+TS1v5kRfH/eNoHC6wJej9z3wG6VmaNDxb7M4GFdjvwBCrnUV48HjwU8CaW/RklblTdMUw5sMc4ZO1Ty7U4uVowfIop2z5/iddJY5jmGT5kQiM/0blk4w0ujrX2ne0lrkrollxG+Gis2MH3p9rE82DvEJ3AsUfDvSz1ssc/FQAc7HmaI2jhL2iE9yC1G2jqumL/1Bw5DtGnCT0y9ZCszitoh9d1BQOxWH4HjyIl/gtvhApbDWKT5cI3QO7IkdYLvfEbL64f9dGQQRHDZi8+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6180ba30-719f-44be-4aa2-08df1366f87a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 20:21:48.8905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEtdlHihsUdyJSwmILObRheoMk6Wh3yakDlQ1wj0aoHNJA8dN1rOeZQMdpn1+ZqNzziK5Q0aDfee8uLUA+71WG+vzDPngvmsa4/ADf5y8jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8260
X-OriginatorOrg: intel.com

On Thu, Sep 10, 2026 at 05:40:17PM +0800, Guixin Liu wrote:
> The poison debugfs handlers take the memdev device lock so that the
> region lookup sees a stable cxlmd->dev.driver. debugfs holds a reference
> on the file across the handler, and cxl_mem unbind removes that file
> while holding the very same device lock, so a handler that waits for the
> lock deadlocks against a concurrent unbind.
> 
> Both tasks then hang. The unbind side is uninterruptible, and it also
> blocks the memdev detach work, which runs on an ordered workqueue and so
> stalls every other CXL bus work item.
> 
> Take the lock with the trylock guard and return -EBUSY instead of
> waiting. An unbind that wins the race removes the file first and the
> write fails with -ENOENT.
> 
> Found by code inspection. Reproduced by writing inject_poison in a loop
> while unbinding and rebinding cxl_mem, and confirmed fixed by the same
> test.

Hi Guixin,

I'm good w closing this gap, however, I'm cautious about claiming more
robust support for this debugfs interface than we intend.  We offer this poison
inject and clear ABI for expert users, mostly device vendors, to test their
CXL device capabilities. If those users take the step to do something like
'hotplugging while poisoning', well then they are just being reckless.

This patch commit message should make it clear the user scenario that would
hit the deadlock, and that users should NOT do that intentionally! But if they
do, this fixup prevents deadlock.

BTW - I really do appreciate that you replicated this as opposed to many other
patches that both begin and end with LLM suggestions and give no consideration
to, nor demonstrate an understanding of, the actual user visible impact.

-- ALison


> 
> Fixes: 574eda81d0a7 ("cxl/memdev: Hold memdev lock during memdev poison injection/clear")
> Suggested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> checkpatch reports "do not use assignment in if condition" twice, on the
> two ACQUIRE_ERR() lines. Those are pre-existing: the unpatched file and
> the Fixes: commit report the same two, this patch only swaps the lock
> class on them, and the combined form is what all 40 ACQUIRE_ERR() call
> sites in drivers/cxl use.
> 
>  drivers/cxl/mem.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 798e5c369cfc..3959ec963026 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -50,8 +50,13 @@ static int cxl_debugfs_poison_inject(void *data, u64 dpa)
>  	struct cxl_memdev *cxlmd = data;
>  	int rc;
>  
> -	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> -	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +	/*
> +	 * Never wait for this lock: the debugfs proxy holds a file reference
> +	 * across the callback and unbind removes the file under the same
> +	 * device lock, so waiting here deadlocks against unbind.
> +	 */
> +	ACQUIRE(device_try, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_try, &devlock)))
>  		return rc;
>  
>  	return cxl_inject_poison(cxlmd, dpa);
> @@ -65,8 +70,9 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  	struct cxl_memdev *cxlmd = data;
>  	int rc;
>  
> -	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> -	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +	/* Never wait, per the inject path above. */
> +	ACQUIRE(device_try, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_try, &devlock)))
>  		return rc;
>  
>  	return cxl_clear_poison(cxlmd, dpa);
> -- 
> 2.43.7
> 
