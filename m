Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86D7F9
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669130; cv=fail; b=qyU1fw3EafsktcP7bB0pSqg0Q//Cnxh90dGXsZqoHAsPXpE4eg2e7X60uDrzb4DYzateIhhy+9yyQstg5DRQCMulzMXj9+469En/C7QkY4+PUgc4VdN7xMNS9qo5yp7dV9qjqMetWP0uBIojmPSO3oZ8y0nKMgveCuGdhfwbyIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669130; c=relaxed/simple;
	bh=LjvIqVipL/l/jV3XBNBFQRZOF/pw5SUsFiRIHJSOOWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R5nOq0ktI2TYEkwTYFhhfaISMEkq+/WxYv6S+62GSGoYMSqxHCBY87Ih6s8/rZyjHze5vx9z4HcA7um7MSbhvSgW2v+TKyyInfLevXB+cHu9cqj8Po0BYiIflWj2nFYrRbS6KRMJ8uGAiSk1F9JIGpomZsLAMnRq/n9yiY6CMig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGOqC1gv; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGOqC1gv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728669129; x=1760205129;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LjvIqVipL/l/jV3XBNBFQRZOF/pw5SUsFiRIHJSOOWU=;
  b=iGOqC1gvrifHYu+4EB3+nQpIJKvgFl4QRtpIIIpRDvPlcxAeVuzuBiDC
   WabA8T8vUAHils5iYD5WYH1iH46Qw5iMkl4BSXldF1xQL5mNGIm/6dJGE
   BCFCDzGSZKa26HyCYJkaBIlAW6FTHcWR0Vpgp75gv2yAXNSDt03mBZxAv
   MYg2ACYaDIieRklvyyg124gh7fMFvoDPC9cvvdcq2fzzJ+agaCi4I/kzj
   gV8/vr+OMHYWvRsUbrQgnrh20rUu+ysa35aYy9uMZlnKNPMX9oHaSgxAq
   u8PoYhqlPpe7VIYL7SBqic0lGwhC35zDBQJlmypRU5lRczQ78opHMbije
   Q==;
X-CSE-ConnectionGUID: XHdaCErVSWSv/as5UbFZxg==
X-CSE-MsgGUID: R3ac15XYQsC87hPGmXNZlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30955936"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="30955936"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:52:08 -0700
X-CSE-ConnectionGUID: evHrQ96CTAu+pMaDXW2n2A==
X-CSE-MsgGUID: GRNvBrLMSzCZ/zHTeWrH6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77284457"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 10:52:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 10:52:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 10:52:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 10:52:06 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 10:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjjqzgeyb6al23DZx4synU5jviovsy+QmfDLzuNjOd3AFg2p/ofH+BnerO9aoKUy5pkQsbvJia6E9r5G5kuVS4VJRaXySLcpdcD3TMUnUqkioaf2SN1OZlrYmG+YHxOclLFpl8sO1o9VOCR9ioj11MJ8X7N0N4S6rcE67Dk0ULIy58yfD4+BN82goD4sHbmLs5UJmXUXXbcg6s0xPLJE+ImLjeVRF/YC2hgoHDcTmg5plUIEfZn2CPeeWbKgjbXpS4LKNjffNxIW6BP76L3Yw+8AJkSdDp58IJPoWsxLBMv5gYXMYwt+6arZEDNTROD/jMi0gaFZoxF6FqzPXxAaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6/ng0oVMLe0Tc2WSB5IGYD+xslMsVNEmHpQbNU9IDA=;
 b=ao4YdjI3ZowvlbUOGcYVy59y9/azW388o//jI+1kP44hDgG3U85QymVToenRa4uowz7RJSQRhqRAlj9pCvk/j/1DVL9aPGNt8bW/1cxdEMPUP3XQ+evjmkIvDWxS8x9TsihTHMfN/BV5oK0/XlrLK5EeYQhSpcmFiv2C75w+4rMkgR3SaDFKVo76eIZ02N6ETA5xvp1r3PBNeRTEh7mHuQu4L0/vNHisVsprZ5VOllbfGfIa7NBkwqlq1GoclodnHqxV4y0ftfFlJO2cbipKBJuG59SHZ7ww4yOmxDrobLomQbnKf+QkHHT7LBC1DHzCaLVnb2yKLq/ORSqftQ8ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 17:52:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 17:52:04 +0000
Date: Fri, 11 Oct 2024 10:52:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lk Sii <lk_sii@163.com>, Dan Williams <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<linux-cxl@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/5] cxl/port: Fix cxl_bus_rescan() vs
 bus_rescan_devices()
Message-ID: <670965c27398e_964f229420@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862484920.2150669.7306809902566347902.stgit@dwillia2-xfh.jf.intel.com>
 <e5da0fb3-f7d4-4513-a0ca-cc0099864eef@163.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e5da0fb3-f7d4-4513-a0ca-cc0099864eef@163.com>
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 689b2505-543b-4d2a-01d2-08dcea1d6aca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+LHeZJVonFpyRx3+OpNpr77NI01wLnSReX6AxI6W8kG6PlA0IULNFw0VxqQQ?=
 =?us-ascii?Q?88g4oL+Wl8ib9Qsh4F/B8dVVElXiTuKjHHOoX467lNiHSdJPJqpzSiOAWNQl?=
 =?us-ascii?Q?Osh9nAKtjVQBNrjv9cHRh/raiEtt/jIe7Uie7rsNeY1dYcC4M/oQ6idnhhA+?=
 =?us-ascii?Q?nBaKjNKbZzP/m2XoZ0lR1lki9huPjCCp80oBHGUSc5HIOa6G6OdS3uz4X+5h?=
 =?us-ascii?Q?QM6jtW2SDC+XHrvFDmdTbQ34ziwsYSlShbh/xYQAmuU6899U4CbxEzACQiOM?=
 =?us-ascii?Q?R80R7l3FJaFzBSfc0HI8Bd+nV/0zttggbduZ2Ms4aG/2Sm6txiheML565YM0?=
 =?us-ascii?Q?vODpSdpKXXwZRw0yBd6CjFaEPaT6wUsqySApMKi1Ah/MxkRz9234LnL6Mvxi?=
 =?us-ascii?Q?r1yzQA52YuyPkBkuTonGjwtVSmbiAuHl2Wc/7JQg+z21Ybp0nOi8FswOJt2o?=
 =?us-ascii?Q?3eYcDzaUyjcnwu6x69lgfzG18M2X14P2gUjSg8H3H7FdOCFQ8Kpqoramq+/E?=
 =?us-ascii?Q?J9fNCYjhGYkMMBXn390aScEDLhn40UAl+L6zYcDQeXX1i8aqfB6Bsq/iwlGb?=
 =?us-ascii?Q?9jg6GaS68z0l6V1gfe3TovinmgMj25+FDnqjN4hScYRmItqNv0nmqM5S+q98?=
 =?us-ascii?Q?WyLPPliCop+IY+IMBuBdQVtg4H/wZNhzAjN8pDkdXDXy/iyIJ3mKLXHV48TV?=
 =?us-ascii?Q?UqgOKK7tSb7jWVAf5g5sPGsTJym5e865N8eIa3fzNKW4E7xWkZ1roHWy1thV?=
 =?us-ascii?Q?INqu4CFqaQlpWSYEpVXe1w6+Sxa+xODxijfiG0spgG7vEveDGZ6sb3QFrXcd?=
 =?us-ascii?Q?XYPjyR//7gJVWVVyvnYF7AwteVqTplX1NsZ/Kn02w+9lYgt5HCbn/eDAQxgl?=
 =?us-ascii?Q?LUYfMzOZEyK5yHfaIR/ujELWW+rhspFeRx7nHkPLc2Z1ZnKRYVhGBrrt5TQ9?=
 =?us-ascii?Q?ZPNtD2SVRA2P21sskC9IjDt2UiooJg+ytSykzzsdMSO2L58X2d7uJic5VNha?=
 =?us-ascii?Q?nR+wUpSgtYRsEdEg/pIftgSykWluX7tWLIGptGiiu7ebuSLbX40a7YRbeChF?=
 =?us-ascii?Q?iHckDuzuyIn2mu5QBenwGe1rG37PHD463Lxs3/sbM2aKbZN1tbhgmYOYNu7q?=
 =?us-ascii?Q?BcUN6K2iClbSvF5IzgbmTsTCQ8PY5jwH7ogsa9hwkYvGEoAPf+AGKfvbzlbg?=
 =?us-ascii?Q?cw1dBhg2cf8BESPu3knXgPq3VITEsKhgWE6SnCO9fvS42c/hLPKa6wW9l1bY?=
 =?us-ascii?Q?XJXWAOicVQQESPKsgX2G0djnDO6pES85XUOwtC8DBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SxAK2IuaKs7pGUsSixSb7aIoSY5fyTYGJ3YAryu9oWybmLLP3eUf/sznb5IQ?=
 =?us-ascii?Q?1OIGh6HPHYjtlIBFsZTDnZT6JpqGdyBSaH2xGnejAIIVOZVmvSyOjLfmpT3x?=
 =?us-ascii?Q?mD1/fxf6BTBVvWVSWajOT/tDnJP8kA2jcY3ytkCct8oEwoCC0ZJIjTHNN9eA?=
 =?us-ascii?Q?mLAH/zo/yqfpj5hFtl+gx4Hc88uv+YtYXLtPct19KBa/5UZ6M7pst5XvUoRD?=
 =?us-ascii?Q?WP9FFFa+7hTsheQHVP9DVwp3IDHinXdMNjnYFuzHvC69GotbncU3On+T2kso?=
 =?us-ascii?Q?hWsuimXwAWbxU0W3GBNjUlyONLjcfrC1HtzA/w6+1q927Yr/8mJBZ+057yDM?=
 =?us-ascii?Q?vRtRdA93/ooVe223KVJfEf1vTvGgFA4uezmb96n92UoOnnjTfE4jS1T2WxhR?=
 =?us-ascii?Q?rYzH1BLh+GRbQytpgST3oquZXzEBJXW4h+o1wadvPSj9aTDBkNiBQg3zqw8W?=
 =?us-ascii?Q?vFWFt05xXlld6Y6ebQxwhGiliaPVIM8KOxQCPoNPHQk9YV2KzP29xQmYylj4?=
 =?us-ascii?Q?+xTVF8C9ZpWTJdH7D4/LB/yOmG7Vtz+0/82aHV02+kmO7IiksHvgW8NwZttf?=
 =?us-ascii?Q?sVCPWFf8SHWOkhbFkiERMod/H+pECqux+E+8abfhXpGUUxjKoHbTjlsbL/Y7?=
 =?us-ascii?Q?x+xAOmJtiGOT3e+gse5aKXdMZGEukEaOI4ozK6bg5nX5kAjvjZaFrbNRDlWP?=
 =?us-ascii?Q?MmWobVM89/1cPplEVrOq56GymFVfzetBzCrArIPRoTcoKfnC/sBuuWAxzEm3?=
 =?us-ascii?Q?LbEBk7cM+fCbpKWvZnXOhLJlogEnf4NEZ/KrJ7cdpMtL9kJWLv24PVDnzHpF?=
 =?us-ascii?Q?Z1yqNMtlU/ybKH0aTLBDrV3aZVRisz9DVB5qPRk5xeHC3iv4nm4jhUhuwCNx?=
 =?us-ascii?Q?3XeOMdfcEaBjEZPiudTbH7U1g7Lh6jrE3zxY5drI0flXhb8d3rDyvWuNsL0Q?=
 =?us-ascii?Q?t2GxYdrO7gwCSL73URRkJso28JkzBKz52o12ltHwrXDWPlTIQXoSDtW/JZn5?=
 =?us-ascii?Q?M0tOuOuLMzmXdINeL1d1zzQElxFqqrykDpPrwNW5G4Pmu9M267rHkpgYqSCC?=
 =?us-ascii?Q?Ee1aVLK2e8K2ZxrtUwc4YZbindfGMQBMbdTI3/4q/HbwnwK2enG7WWqjHc6x?=
 =?us-ascii?Q?DgiVkNX5Se+JBZLNODjkRzFGLT/lednpwagDV+wtlznFqYvDkjC6/xWfTWgX?=
 =?us-ascii?Q?r/xdqUKCRRYVAxnGGtezGTdWtXoKu2/Nz/PqeM+3ADhehHRSJrNV/n6010kF?=
 =?us-ascii?Q?nUd741UQYIoYgLipgKaYrJsIeUrVLHygSKOfyd0oD8omub95WjywYLjLFZec?=
 =?us-ascii?Q?kxCt6fMr+bqCANWCz72y/TflQ7oK62Ebm1I3WRpAuwXjX+JrCAHAUn8M7kXK?=
 =?us-ascii?Q?kKseQJE9w5vZ4i+2axq7LckxEBMQ3duab4nY/wiQDQvF+hH4Z6pETsQV2UOt?=
 =?us-ascii?Q?/LVafIlfVAp1QUn+qiSM+7/iJIZNtS9LS6Bm6qExHYZTR1q9UI6k9xvtUsxJ?=
 =?us-ascii?Q?ETsgAFRAICpzmnQJrIf6kH3Ax7e45tVa21fDqhQ7QxUvl9TbUEyD5FxV3x4D?=
 =?us-ascii?Q?Sl+Fu3ICNKDE3exjaOFW4XNU0tXBlP6yE9CgeFxOEPGGlH9tX0rdC617dhse?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 689b2505-543b-4d2a-01d2-08dcea1d6aca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:52:04.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5oh8lX7QXDuDud3g4FxZ+kuGB5KAzTosZ+qhST/0n7xqQbm8A8vJWXh676yDSRdWkLTG04qtEmd5g5mZtDszpJUBFLXRRv9uqa19hBcpvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8184
X-OriginatorOrg: intel.com

Lk Sii wrote:
> On 2024/10/11 13:34, Dan Williams wrote:
> > It turns out since its original introduction, pre-2.6.12,
> > bus_rescan_devices() has skipped devices that might be in the process of
> > attaching or detaching from their driver. For CXL this behavior is
> > unwanted and expects that cxl_bus_rescan() is a probe barrier.
> > 
> 
> is it relevant with bus_rescan_devices()'s bugs fixed by below link
> https://lore.kernel.org/all/20240913-bus_match_unlikely-v2-2-5c0c3bfda2f6@quicinc.com/
> 
> which also checks dev->driver within device_lock()'s protection.

I considered that, but the complexity of taking the lock combined with
the risk of touching the the long legacy of the handful for
bus_rescan_devices() users (hid-core and pcmcia), I decided that just
using bus_for_each_dev()+device_attach() is more prudent.

So I would say, just document that bus_rescan_devices() is a legacy
helper with this old locking behavior and direct others to use
bus_for_each_dev()+device_attach() for new use cases.
