Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248DC443E45;
	Mon, 20 Jul 2026 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564646; cv=fail; b=Pm3f0Ba/pO+m66DTeu3YAvy1Scfpbw3P+F/CNeoaVh2qGq8leF1XHdGiS6iFeaSKYrG14lV3stSWEMmubFjQ0NWedHbI6JSX4m4OALjMjXS1KgDQneMjbrSFToM2BWa6sbKbzOBeuxi6EApVTRBGr7ffL0yP157SJ+vlsOYJGQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564646; c=relaxed/simple;
	bh=c2/WprWCqLon6FzSHW15Hj5biNIkl3Gf23xhzZX5Xic=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f/9CvX3li4XuCacH25y1oFTbRh9oywW9tVgLr2ICCTAz8CAfjx541plNJJdc+sjuEnH9Msd2LHEiU+OgusPKPll98sDL6+gui/vbi5YR6PapqfFKAkCL4xod72pZGMeNKY1UPiu09LhofDTlwnGHaziabgyv+/r50bZTzUbQ7nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=du8qrFPs; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="du8qrFPs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564644; x=1816100644;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c2/WprWCqLon6FzSHW15Hj5biNIkl3Gf23xhzZX5Xic=;
  b=du8qrFPsxDYHgI3vkYp0IsmBmsu9rkw/cVoe0xgB4mm3ChivkclmqupW
   PNwZ/YjFDTMVqMovTjVEQFWGuLYuwnQ3s4czA8JivMVxE019FZah5d20U
   NBxN4x20HEo6mUNOnVJnsfCIoAJAQoaSi1LKPdi0Qxn5nTB7tMQOelvwP
   R9a6CijY/ONjHpWPrETGYUI+rwFXnLRtjRcMzNvsyaCyhPDldAZysj/ol
   K5OxUGoe7wBhGuk1TareFjyX1bR20ReV9PeMc5wEffbJRWvY8srnZo+tC
   BpANshNTzSvFZUmIelzZ5uuOS317Uy0PeHj28vHBuKtMfi0Z4g8ZRirx2
   w==;
X-CSE-ConnectionGUID: v6C9XJ6GT5Gouq5pjabrKg==
X-CSE-MsgGUID: 7UObAJ/xQ1CxjuF6dC0ouA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="110702451"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="110702451"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:24:03 -0700
X-CSE-ConnectionGUID: Z2HeaDjzR5G8S7w+TykBQA==
X-CSE-MsgGUID: kUeQPCmpQM2WldoqIlEoTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="254090901"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:24:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:24:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:24:02 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+5Vcm4XN+hGskHdWlEJn1v79HqvuvkVPsN8EaFzFUrxhm0mLjqqlcm4lkqCAwkCLcYPSPDLt0K54SxGB5P/gE2yDgD3Xk2/RAa3i8JmNRzBxij6OI0P12ePj9xTBf5GR+/kXtiIxbB4DSjYbZrtohevxuVJVF4xGIC2sMxgqm+ToFL2IdRA4l8AKMi5iAIiM9WqVb6hcMw0LHH2cYsKMoQLCvYbhzzsnOEiAfOzDU4DPQBH+JNih2U01Fs7Bo4TXMxlbTjHp4Jengjc+8OxcrqQoA3zlwW/ammFbsOOCj99GpvAzd7WhgxnSFo0PeiLI0j/ZAdFixRwFpp7Z+tFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGN+xbQ/PLsS1Ne28YD7cOMYklLBdZTzn/SvtqTwrmg=;
 b=dnh+CNrP7Sc3kcANTLlJZRNOUOeB+m8g6P5c10JLer8E6AF82x8CU7VBvvYY+f7cUW3/R6Rjlzcict+qic+XVn9LO2XPq8dSH8NYFxk+AXhYugV6vumbSNmmdRwK1n7htdL8NPV12JkXNa9/enmA4YG8FolbtfgoM3dOhsp5qtGfPJe/7fsQUcNcScu/dKaRdyEY1IekpkdH32vZ3pIIqalLMzt5tZZsVpfG9ZwOFgsG71s0LjaEhtpLnRJlFmiFsNWiSro8bYvhXTwD4jqcyEqu7UFKDIQ7C5k9++vgTcj3honwJEmiet/ZxCdoeUttt2XEvlqMluxEcd7wvUCWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7509.namprd11.prod.outlook.com (2603:10b6:806:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:23:58 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:23:58 +0000
Date: Mon, 20 Jul 2026 09:23:54 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<terry.bowman@amd.com>, <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 01/10] ACPI: APEI: GHES: Bound CXL event record copy
 to the firmware section length
Message-ID: <al5LmjUbaW3tz_ZD@aschofie-mobl2.lan>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717161647.1493259-2-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f158879-e680-41e1-934b-08dee67b4d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LfL2LgXJP6KtFK0mNJ3ID6GmynqJgiv4rmnX+Wtkz5HV2cduowSMN/4qLh/CUUnHi8FZAN1Zuv2ufN1XyR2/zf7zp3aSfgu9cim8DPHugTOeMQn6N/82cQjdze5zxUR5ZpsE1WHixte267n6c4nWHslsQabtfUyzGo2RtPHuxTan+jDJyVq2/UwuYtHJ/RL2HX6izckfREd0JA8fbttN9sG/t98arA7Eqq2uqY2obMfdnj0KZz/lULe0GKPFu8OSxo0ye5p78mvp68tTsAmTYwZbKjyzujBlJS81d01CbKAyzaZU6Xe9hN87ZATPnnt5yy61Bwc2iz+rsGzduFooXCBYYk/NesDPSNj+y2qKeK4UWw2P5E/Snx2Plg3knzo67Uysp9foaCRhYCG7UQNfgMPL59d88ktc0Yroxe26ljHTJNwuxvESZv0FHTjcXxVKOu9ntRoLY6ypBFTEri2iW+XrLlEQHd8EaIBhy2I702YXCobG/ZPvuaDxsy8Iqn4JTKB4QbKGxxG/8cHh1M620O7ySGeann8RthxndHAfxHmPlnX1Z9x3yt7wsqx6l6AwahXkGoclxKmNOR+vKXGb9HcrcTqAOUZc4eDDs+70mDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D5GG5pxQyn3TkRr8+kP+Vf4hci+QMlUl4hJWWSLFiE33fqT7U1XCAf5CONzX?=
 =?us-ascii?Q?AO9mOzcJRfPJ8DHTJV4LrGsVRw8p06pneGPg4B2OlJ9V9F+bWNuJF8aO6rlK?=
 =?us-ascii?Q?HGvUJidofZTPhWPhlOwwYFDvddnDnp/der3kQ8WoGsle4VQ0VITa34ZqUJZP?=
 =?us-ascii?Q?2kZgRDsm7Xe4EFkImf6ogEa/h+9seYObaMYPGHq9s6BsyMbyaw9q4Y5bj3sb?=
 =?us-ascii?Q?7eJ2K25N9x4uqmR6xe1EH+u/ImKNGE/Jr3mMHlQKyc/1I2ZHcbCLVYg7/h/Z?=
 =?us-ascii?Q?TOnF/8IoUbYWy2sm33acBfHVaOGCRsJoVGStZ/7St/NMa79i32B1NCFTXg30?=
 =?us-ascii?Q?RBukYx5Qp5EVmArm84h9bT1X6ue1BL4N4Vmpq65gqq7YR800e/PAUhvBXpLQ?=
 =?us-ascii?Q?sttl1I4T6bKJaq6KDrjrRyFR4uz9fHda/YyizwfK9yFEIpc8R8ABlhE9f1Kf?=
 =?us-ascii?Q?/+wz04gS8DXu1zepHobyNwLIGgvsohCPp6JfbpkJVuwsz9P+Xb24ifjK0vGx?=
 =?us-ascii?Q?V3k2aNpUripjpA1SASuuvS9rKdSy8VPZonbZWtfS2WmDcF0NFtgX1WszQsn3?=
 =?us-ascii?Q?RbK4e6UbGya9T1PBkb4gUFqvIAkDwLucv7KsNqQOpohGQ3caiIdp/KAE2q1J?=
 =?us-ascii?Q?qZq12ccl3lfMAzS5zKvDiSMBTD044m1BuD2GSxPwhgly5SRIJAD/7FMKewTi?=
 =?us-ascii?Q?Y1MZi2A48KAtrlbZmUo67KQAp7i/QgK4DitBNkHbW1aUcKlSV5byT2LrXcKD?=
 =?us-ascii?Q?lteC5QhwaBJipCbw/qaCvO1f0nr4Syvp3pg0iYBIYv5UQM0Sz8qszinKqCm5?=
 =?us-ascii?Q?7l1+lbz1Pv2xN7yLrAXAwxVx4b/O+QpP977AUyKEt+lUSnI3KqTbfjcF2xYA?=
 =?us-ascii?Q?/Q1i5E2tyaPcj5x2KkxtXbAb9wItgSlS+T6ICFZqznbHLCYINNaNxPcYS9p4?=
 =?us-ascii?Q?QOMedybFXMdsy4ElBHXL3JJ8QDtisH9mp+56ikXa0CB/ouYWaNsqGzSFaaKO?=
 =?us-ascii?Q?JGF/hMQCATiY4P+Snq9sHl+6kYYQpFSxoNhaw46FS0LH/eSILbDVCpiuf/fG?=
 =?us-ascii?Q?hcnlrZKdwpD8DCvfnnGSL6OdKNl8gVVDDLfk5dxmVwMUNUJaUfeK8vPrNBAW?=
 =?us-ascii?Q?WbtLJnC8SZVWvJjdy2vSS7Dlszntz0i/G7sRb8BKFdcrX6FAGN8vDF/W1zle?=
 =?us-ascii?Q?O2hfXyibJaH8MEfjWCY+UveKlXpo/+i/OOKBZZvDYDaMxA1HHSgfQAuCsBXc?=
 =?us-ascii?Q?/wsASnr5wa7Q9niCX2DsD96O98zVAs5USdvrv7uF7a1MmsIeAZ0qe4aWyG4v?=
 =?us-ascii?Q?oDENmAIQQN9y2vANT6ELowHhs9hi3IFMTWwBeircMX3Ap4nOP1Hyy/AXA7HO?=
 =?us-ascii?Q?mvGO4EEIYTesCncX/30XUhb6A0BwKBrLXmJIGUigXtBDLhcOEhGmL3+JEaGF?=
 =?us-ascii?Q?uqxwjBfO57tiQefZooOir8/Ov3dfA9LzFs3Z5I8XxTtqHnMkD9iQqycIJjgS?=
 =?us-ascii?Q?5RXtXVfuFFbAuGuRRvoZMEfrMi7RtJRbDOuzB/dy6ggx3fIuoTzNq5yXLDdm?=
 =?us-ascii?Q?/CMcSmrjiHSLgm5D6rx1VxhejKHjM4nNG5dAm5hV0PZrGisOnHHMmiGVs2pC?=
 =?us-ascii?Q?GcN7tA4wv00mwwydQrM4hy7qpS66nsFA91sGDHtX6nPvS8iacZLZNXbG26WX?=
 =?us-ascii?Q?FtKKTgrrA9kAg3a3XlC9dVuo9IMah+tLSnRUg/J2R56ddiORjtcCWGRBrtc5?=
 =?us-ascii?Q?LAKulTh+aLX7u2kHKPrDn99WWU01AOY=3D?=
X-Exchange-RoutingPolicyChecked: imnrkUu2LkNMKtMPz33o0KxjyivXQ5CSTx2ZcMfKYHTbz4Eyw2DK2pdUMBXsvMe7kYMrV1d5ScDEK6jQmX2xIowPkS6+39A9PtSNdAYjSpb2iHXeNHcsyydJCtbxhK62GA/Iy/tMd5/eXNnC6LGqpeKhYORnNrelL4IEQPz7YKMkDK8sRPp1vs0hfJnsz8/XPCC+02ph6GlFZY+ZTD50OEKVkOyQxX6TGoSquNDCj0RMM5jB6E7T/XTf7thPvTqJ083a6IoP5T4RubSBW1wEnmjFMp+vRCt3p8SmDiGoJeEQ6gTwo9Lrp0q1AAETFdSprYXZcuTCiUrwZjQuHRzemw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f158879-e680-41e1-934b-08dee67b4d36
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:23:58.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R74vmGJtoPIvXS2jGgzsGzT+beAadyDSEvxs3zsNAKsDKXWTYhabHIvxoIMEspjmxCD1pc20zNwrIdNjArfKOoAuOzLW/tB3uqVMDtt6CU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509
X-OriginatorOrg: intel.com

On Fri, Jul 17, 2026 at 09:16:38AM -0700, Dave Jiang wrote:
> sashiko-bot flagged a missing bounds check that allows an
> out-of-bounds read of the firmware CPER section.
> 
> cxl_cper_post_event() copies a fixed sizeof(struct cxl_cper_event_rec)
> out of the firmware CPER section without checking its length. Pass
> gdata->error_data_length in and reject a section too small to hold the
> record before the copy.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
> Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
