Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931E8C0B;
	Tue, 18 Mar 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333148; cv=fail; b=PMut+mr7IHyRtUa1wYbA8h7EacBc/0OmUwS5tKvCdjZrUiDwSrx2Bg8fMlo9TyihBoPnezTCkLLciqg64rGoD+SKgng+VXIMXcn46X5f87IihrGgpVUYgDRblSjDClvCdQBEr43jMNw0h1bZSIuvzJAlQSOU8crZFAQ1RSvNgMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333148; c=relaxed/simple;
	bh=R7d2Ju1QHQMTm9j0V6yADVjZ39sX9VU+xNk/jp/0V4s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tgk3jSpyHfqLRIDCJ0+9tXH7WQ5qG04Ik522ZBSkQAfljiYUxwV506ugbz/cHBTMckUibEZ3SPAN6B6CPtw0xO7FuTor8ps6/Vh3/gIRrzo7WZLsArsadA8KzpiHBODitx3bHilXBNe0SUS2yb0VHhKE2z882y73OXNOsCbPqjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9j2AgFu; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9j2AgFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742333147; x=1773869147;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R7d2Ju1QHQMTm9j0V6yADVjZ39sX9VU+xNk/jp/0V4s=;
  b=c9j2AgFu/vx+hYsWNTT1SHcpN370AxvNUWg0qy2U8Qvl9fM6wjcHevW/
   AAKyPnYUcC/5ZBf6/c/k9fs+DBkL5nMcaXckbqGQF7LWWHxbn/nvnRQ5s
   7hioLM/uhiXtI/wlt2aVHRGjKEBUM8udMbR6lTmxSGsjV8Dag6z8/6vO+
   Lqkdp+cLvwqxBvTcLH7MyRojgScSlZN2MkghYe7tBGG+F8hfSN4X5lJ3S
   zAouB1PA/qDqJAZ6a6hdJoSLf0o5QKnKcYfu1o+PmIZXFSCt3fQLVQMPz
   3WeNdfj0tMFuwjgxqeXgqvZH7bF5jzBgv9sRidMIG+s7CIMjpGJ6f2UZF
   g==;
X-CSE-ConnectionGUID: ov70fAtoRPSz0D6UjxiWmg==
X-CSE-MsgGUID: w19JDzcHT+2Az3//37DiGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43634256"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="43634256"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 14:25:46 -0700
X-CSE-ConnectionGUID: TwoTJK/3RkGgF+UK3B69SA==
X-CSE-MsgGUID: +v4NrtwHSMCrunp5dxRiBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="127425759"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 14:25:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 18 Mar 2025 14:25:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Mar 2025 14:25:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 14:25:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKqwcYDzb1xI0nV3uWEDJGaX435ppr66OvH6G9T/8M1di5XHS8nSf5kd1p9WuVolACPwor+UHL859BMkRtMsv1q8kKeFlf22+lOzuZGqKSF8hcmNe0yPugBFh+xeO3jnx3p4jgjN8uWQ7epFRb9TDIh3DJmqVIhLUJVmsLZFmP+wIdoSvSUDa9KaE5SkeiwfXxBig0QFVdx4TF2YShbiG3jNlU1IT9ZJZvfyMYTg5jyM9TjOUbeoKJ7tdmutdiMxnMQLmwJE28ZnFn4skzd5Ujk/pLUVZNIg/77LR/7WwRRzriId5fHMF+hUP03IX5ekyJRd/7+rD6T2Em4fe8Ol/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL96s+VQagwAD1BIO/uhSLiPRPHbLZSKsvrRWQg9U8A=;
 b=pcrAkZM3c4+gEXntASJ3W78m3ZsFnOP+f/6nJxmiUEF+WBk+6jZmiFtc5wJcvOyt7EhuhKuqhP+TuKRXwx2lKR4qgrlfH5/ruxZNS+M7ykVsn5S2SAVeVZMRuTkFsMy4VgTR6GtEWDO4TdDs8YdVxiyatIuobAqil+Sney2iCYGveCcbGiC7qqnamplp8C+7CuT+jAxiRMlx45b1tFL2s3B2V4HYn5IxKv+Kz3AD2PvEGyxf6t4XFUekXorbQgp7u73gDqNVOLulEOS/isFQFQp3I2j2vfeWmttrVt6SIjqqfCbeS4WUxa3IOhe/eL3dEJ27LjG0jtY/cEnYcXrNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5804.namprd11.prod.outlook.com (2603:10b6:806:237::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 21:25:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 21:25:42 +0000
Date: Tue, 18 Mar 2025 14:25:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <nifan.cxl@gmail.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
	<dave@stgolabs.net>, <linux-kernel@vger.kernel.org>, <anisa.su887@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [RFC] cxl/region: set numa node for target memdevs when a region
 is committed
Message-ID: <67d9e4d43360e_201f0294d6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250314164629.6937-1-nifan.cxl@gmail.com>
 <ac564c1e-95e4-46d0-95c7-7f72c8fee0c2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac564c1e-95e4-46d0-95c7-7f72c8fee0c2@intel.com>
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c1806d-6536-47e6-05f8-08dd66637019
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yziL0rxH/VXltkbZooBzh/ltOAh37fNEFMb75rH/EBkuYzu7rLb3GuUNPkhd?=
 =?us-ascii?Q?QL1Pgs09xcD91LAmtl6tMhs4hw9V6wnKqo2/OS+ZF4bwtEygL7vweem0E3/q?=
 =?us-ascii?Q?lIDhOfUAZW4qHUaxH0QMPlFdycY/RdE+RogVNIPmcU8gzLzERNopgRZtsrQs?=
 =?us-ascii?Q?pR6F9rwWxRUyH8rq5sx8XEi6t/1qOBWxr+9kqctenkGMT+tnP0V20QMjKAfV?=
 =?us-ascii?Q?gXkPy1ZP8EzArUlpQRfpGTvWEma9sZkGbCehnbG6V+xGu5s8gPKmgu/8BWr4?=
 =?us-ascii?Q?Pg29dosHZSFec4w73VQRYI1HbEG60AES0N5zyARtBRMh4KaDClgeBbgDXbhy?=
 =?us-ascii?Q?uTOgU1vRPs0WJX1oVcBjJPDLS7ZTdhhGqK6BZ2zjasO2j011BYlx468M6VVl?=
 =?us-ascii?Q?w2FhRxwJYEkoeMPdzlUOTmKVVZFC1XEVhKJN0Cd1DQ7SxWMg/JiwGeCaDi+v?=
 =?us-ascii?Q?3smAUopJNlKEHOY85qDwr3zawETsHGcW5frRDbOwtnVNnJeBu6wGM5SlwZ5Q?=
 =?us-ascii?Q?Qz2BRqpYy3GTN9xXPKzsrE+Xga5at9LVjBy9oHrp46gMkiSh02tdKGPUhUDk?=
 =?us-ascii?Q?p00cXt3iWUjFmccUc5Gd7j6mk1vKt/XcUKGFtWo/UHpfAzApdyAwJMNbD3l4?=
 =?us-ascii?Q?Qkdf5WbV1b/EptdT9dsaLdodPzRo3WQrojYyq69vby3wpvXC7Rc+1Vel+Seo?=
 =?us-ascii?Q?IxjOsw8Xt9nLwTff50qczUQBuyMwKmKoAWbVFark82ttH9eKz60LBSRTCfl1?=
 =?us-ascii?Q?Bqur7EFDvWWJHO/bsHDXrgrub2drw5d0DrWBdOAr4tEcCUTRdcauMWuxb6+D?=
 =?us-ascii?Q?NcP4K7JZoWCvn3JYBQRgwgdss25swvFE8g0tWSU5IBJGgtC0iJN+cLHYF1xd?=
 =?us-ascii?Q?6EbJUm66efiVv08rOn3/fHFzBCE76EG+qF+QQKqf+VaWWn3u/WTQ3zDH83h/?=
 =?us-ascii?Q?e+RIaJ1G/NLNtmf40Mb1nrjHMZb+PqxfJS/35cEl+Q6UmqOACo0SpCs3KAG4?=
 =?us-ascii?Q?kIYvs5uJdX65F11W18hrv4pjPpJurLHOYAJv5I6hmq/EiTkN5M0gwti5DSbB?=
 =?us-ascii?Q?dR2PNFe3VzheOem53Sb94Vau0UhU7rgcBP+ec34yR23ClBlATqjntNxo1No5?=
 =?us-ascii?Q?JDh0OrtAKZ6EcYOGCedzdcwDhoba/H21jrrgVqdxG6j0KnoDZRFWdZEOXXNO?=
 =?us-ascii?Q?5dDewSnrNEymebgJnWQ4mvyMRkDg+e5KZ7nQ6FkqBcXM0UkeJmAZWWGfm4bj?=
 =?us-ascii?Q?qDdGjTBXhWM12v/CkhXERkgMjG8QeWso+H1M8xD7c3DlTx3IYDVhJAIzNG20?=
 =?us-ascii?Q?AMdSB9lT2rDtQl0XZ4snHMzA7c0RVNUTg8lMfEQYWaqfnElpdtfGFr631UUv?=
 =?us-ascii?Q?0eV1FLp4AGRGjJKYHCe98ZBnNfFs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qWwInJh9mNWxnNaGapLHsIHH2iAdv1fFz4Gs04pqi3RP3AphMU+6smnU4BWJ?=
 =?us-ascii?Q?9voZkfnIpk4NOQEAUyqE1bCQvTnWBgYRG0BCBJrFzM6nMtbEclYnM4kfCTl9?=
 =?us-ascii?Q?6RUfZnR5K2/siXU7gUbF3egJS6An49y+AUcrORdmdGk/qLpDA1XZwFJrz7z7?=
 =?us-ascii?Q?eD969Fc64FD4crIlxAw32olRec9WQzkIzbo+NzS4QLWgRea5BL6vyTksKIti?=
 =?us-ascii?Q?2/pHIgA0rkmc2MgJd8JnYGSUdP3NbeJ9yaKW/S96JJDk+1dpryyrOd/4nsrM?=
 =?us-ascii?Q?72DqVypYChdJBxxp7KJ2jBf+af3v5IbtQ+b1TMErv11oW5ECTDUr8hiPfoNv?=
 =?us-ascii?Q?MUQZ6F40wXhtGETEpJGyTH3wWNdgVbLWb/MxrGSC6jfLizTJiSqlrJorLOET?=
 =?us-ascii?Q?Qa7WQ8EOH2rPsF9o+x1OUHtVPFc9mHPvmBUNXA02b1ZTkSmj2pnnQUpqIYZd?=
 =?us-ascii?Q?iB1S+vbIrU2pKII2vHN82ZnonWr2Vt9oXcyA+6QRTEmkJ3FEKExA6cLYdmHD?=
 =?us-ascii?Q?oPShN6hr1L6594HnHNQp0dOylRts1FyMDNeQYkDfm217GV2h8xIoDXri+s/z?=
 =?us-ascii?Q?h/jk3Cc+QMJUier2WSENO86OtkBOY998Rh/UDPuIlfiT4fDSCpgUSWocdsYW?=
 =?us-ascii?Q?clKdUciyX7qOM+IoEROKdLYO3KUUjDxCj0E7uB6M4WZDfDHjwxrXTPEw7MOR?=
 =?us-ascii?Q?LdRZXSl1rY7KA5vKzedpOjdFXjlv5+N5oRX4giYX3j6Xi9SdhtgCcN1A+NHg?=
 =?us-ascii?Q?x32kSEKMB2IRmq5pcOTVNboWwLxKAZ1OmdVuoNnuOUgBwySN7TyfdKhuEvAX?=
 =?us-ascii?Q?sy1tMsKTtMCedEJORMb78rwAJu58FltxksLP5zEVDgK+LIA/YsQkSEcE+RcF?=
 =?us-ascii?Q?BrFaoltcBfnYFIJVPRwmyRIh4d74p4npwOT2Q2LnlwKX6TtDRUNsGJWXXbN9?=
 =?us-ascii?Q?HOlCwx7FMUeYwrzUwvWjVmQo/6qaRdMv3D3No1RnKQO3jjVYe8FxGSMt190b?=
 =?us-ascii?Q?E7pD0owXpk6cXAhzGTewvqXbuS3++02HE7nF9hdN38KOJer1PEUmLuR2+ncd?=
 =?us-ascii?Q?v0V0/a1eEVoMsJe1gmetOlyYDBmOziBYvFDy2E32g4owDa3UYTx1ePNA+BNx?=
 =?us-ascii?Q?FVohwPDOLFRQy2IixIeLjHKOnjIbblc/rFDZBPmfnKV8iEVHqyKVhgNPIqFz?=
 =?us-ascii?Q?BF/mQJUpeU+doYVngKeawMjWldOn8wgmOLQ8u3cln7g6a+x/t96yqY2XRNRF?=
 =?us-ascii?Q?gmfXhUWBnmjbhtpCqrTjPOncPgdqf3EVXg0lHC+JmcXFKPYeNaVDyTltKFrW?=
 =?us-ascii?Q?M2Ua4W9StF2gwQiprXtRBEyCk+f+pXf0yFQ9THLu7FqaLbUTbti7kPhwe50X?=
 =?us-ascii?Q?C9p9bwQHD6htVPfR+vF6P0noiskg73Wnb72Q2k8tbV/fLGsY/2xcel98hLa+?=
 =?us-ascii?Q?rJtXaicnr1q3fzoebQDKndb3LVjvMEQ7kESza7HRwvmiz64/c/6z3Ve7KaLr?=
 =?us-ascii?Q?Khj6OO276bht+UcA6wSYxzz2a+NRu7OAvEqTt8eI18rZjbmhy2+GxcBcsiES?=
 =?us-ascii?Q?UMPBlQB6eB54taKA8ooLIM/zvNOrfoCkQUygPJoTd12pkLEcwuSZDOvSlZcu?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c1806d-6536-47e6-05f8-08dd66637019
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 21:25:42.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXZ0hR0vTXKwZlws578ZqKd3vE0DX2QPUBPreZ/2oZoyXTrCb/RFXQI1CfvER0qb0G5qAfZ4S16jT+mOfbEVF4nlRZcatAi+SfEW+T8pTH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5804
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 3/14/25 9:40 AM, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > There is a sysfs attribute named "numa_node" for cxl memory device.
> > however, it is never set so -1 is returned whenever it is read.
> > 
> > With this change, the numa_node of each target memdev is set based on the
> > start address of the hpa_range of the endpoint decoder it associated when a
> > cxl region is created; and it is reset when the region decoders are
> > reset.
> > 
> > Open qeustion: do we need to set the numa_node when the memdev is
> > probed instead of waiting until a region is created?
> 
> Typically, the numa node for a PCI device should be dev_to_node(),
> where the device resides. So when the device is probed, it should be
> set with that. See documentation [1]. Region should have its own NUMA
> node based on phys_to_target_node() of the starting address.  

Right, the memdev node is the affinity of device-MMIO to a CPU. The
HDM-memory that the device decodes may land in multiple proximity
domains and is subject to CDAT, CXL QoS, HMAT Generic Port, etc...

If your memdev node is "NUMA_NO_NODE" then that likely means the
affinity information for the PCI device is missing.

I would double check that first. See set_dev_node() in device_add().
