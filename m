Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93B436A003;
	Mon,  9 Mar 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088146; cv=fail; b=DDdbb60rnGlYVCWDiXPJy9yAB/qlzVYZKBgw1pTkX0IQW534gOt0+E9+atdioTYqrlEpX+u/sw4D9Dcstgpy63oCVMguHsESzcDmfQKsH4x2GM+zBo3TaxNiZxnOPKn9o8JyiXlWvuk9BeJzXBZonmP2aK1UnBdMEllgmLJ13Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088146; c=relaxed/simple;
	bh=p9iB2CNuiDZln5a4wjG2MTonoKa8JPpCm4BHzzqPafI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hmOYdQLwGbRaYAJHv4gdId++BToFFtEHKDNwR8QgsxT3gQ1r+xq8WF6P0LJWxAHxXOae6tqLoQfIGHXYJMqouI8wghB/IS3qYOvpnynB91OHxamKBdtDiCxC3Nr/ImyGDLGaYLEYworS8HHxCIkGSCRkMHQ0SiDKVWzSxNz38/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbOaX/pB; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbOaX/pB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773088144; x=1804624144;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p9iB2CNuiDZln5a4wjG2MTonoKa8JPpCm4BHzzqPafI=;
  b=QbOaX/pBEoOm7SpWy1iYvTPAJhZHkwHD3yAJ03ZX2MRuEG3B0sso5AUx
   nPyBpeSwyWhtTLjfI93wQk/Pe7paxz1Xsuzj2mWqZWcSMwuBW7sbZitEy
   VWk7CHyYpGbExQn+zgLY44wPN1LyDcfVtcapbm/60iGePgTaNdCvMNnjU
   a6FxUO5T8DEC9vK4wVXwQaUW3IMdUMSu+Qb6T2No7yaPQ+J9Jhm4UQ/CM
   eJRsVrFMZk0plGJFWxVZjgPd+EfULLMrdxQo3ERVfqpZDzCg5vPR6H9f3
   Yc4BvcgQoxwwjgnWLSwJ86AcyeqK6vuMj3PJq9/RGVEM4+GmET3sJ4pA0
   g==;
X-CSE-ConnectionGUID: P+Ag+n1BRB6qkmdtZR1G4Q==
X-CSE-MsgGUID: tuT5WDqGRYS0UW6QEX4MJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74096435"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74096435"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 13:29:04 -0700
X-CSE-ConnectionGUID: EKzR5dbpQC2h8LXMGaaGbg==
X-CSE-MsgGUID: sFx8GsFdRamglxKz7U/GWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="242883453"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 13:29:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 13:29:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 13:29:03 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 13:29:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/mVM4i90hncj0N89+ocFZ+/WLaQzAw9mR7mvHnnnSf64rLWXgDKwPOIC1uxpwE4CbtM0EFrdRg73tmjilw/u3IMfXhJZ3oW2XA2stOoLpSFAvTRa8ZVIhbgMdIoN9ul0hV9uf7eXIvG427klulpkcbFxpD10u4rSTUkvwSsEzkf0TKi2xUw8VhUjbAHpr5Lb3tYmQOS/IfyeOOUkSHs3gsN07zFJUWzd0ffYr1bH4E8w+r/xhSth9ZVRJCSUpE0BHQVIZyQGxXcgwfjPzR5Dlg24FLh3c8f9ejORuzjFuXeN0SeN2y8IDhGVIb/tsHv+aQ1LqHd5C2V9aeSmM8ObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eA1hCSxc3E9yohZVveZ9e0/RH9OZ3C8h2u3djP8c88=;
 b=kmnvjm3QukwxybI9s4YWQN7gWUrMqi6SZFqN1KB1WnZk60jGQfR1LHi+wR1b37dSEqM+AL60XT072wVb9n3oiJSJWVPa0iDUJL7l/vuW3AaqQelNSVxe2Lgog9n/8nLM9hnBSsz42M0p2DVdfBbkZM61kJ7PmF6kp8wHPNg9P+5hTFGTOyQnH05GhmkWFs5dDIn+zTlrSGyzpW3gnAn3zUxjpugUpYcvwmrhilC4IpfuqIiIIZSZfEq84UEgErFYhEHYqLBrifGl8SSXUQlbjXpzLF2Qhyb2ZRtALaKdn/Eo4z3Z95lkXQb2J0sshNchl/cQ9KbxzcvxAdg9HUk6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH8PR11MB7072.namprd11.prod.outlook.com
 (2603:10b6:510:214::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Mon, 9 Mar
 2026 20:29:00 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::cedb:24cb:2175:4dcb]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::cedb:24cb:2175:4dcb%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 20:29:00 +0000
Date: Mon, 9 Mar 2026 15:32:42 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sungwoo Kim <iam@sung-woo.kim>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
CC: <daveti@purdue.edu>, Sungwoo Kim <iam@sung-woo.kim>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix a race bug in delete_region_store
Message-ID: <69af2e6a81cf6_1a62c11004c@iweiny-mobl.notmuch>
References: <20260308185958.2453707-2-iam@sung-woo.kim>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260308185958.2453707-2-iam@sung-woo.kim>
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH8PR11MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec4dde9-9c0c-4b47-3675-08de7e1a7f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: IAYVwme8aOxf/rRsKK7BuPnFyz25GC9lJDJQO9T1pnQq35LElUuJM0CH/uH7eMpVtljSyANL7cv5CNk6BD5YrJGy0zyIdjmlotVzaoGXducTJU7nDrQRbSod2vsJGI3h0HbI+TDyedZynZLPxuhJNcg33l8Gigpe1e2O4xFLVVOs0fhA6IP1RbVoXG2cLP9/n1yLjis/KS8ghSgmafkvDMscSoDl3z+xMdsZZ8sFDLgR55I3gH3bslAIRJoIz1XG+Lflgdtzic99aY9HIauOrr6pHOvicZnUIdCseqV5OUll0rmnABaqKZapOG2DmWI7lfTm0SE/xSYGMVRPkFBe1QDFI9bG53VujzBPsBB8eRGQMh3ytzBuW5FKwJJ9YSUBgPPGkJ5aI58wLyKJYNPLE+gFOWR5XdEN/LaThki4ALcpBMPc4xkwbP6OPgMMp0SNoXNPP7hLeA/SphUwnDveBlorQELkOIopaX9eguokOx1RvGXEhn84On5ZjZ7CZ57+y7RGAXgW7EBcwlBY8N0BN5GjaWGXqyAbL8eiHJm8pYNh3bLEuBc/qrY5bbG+Tq34Bx4dtguHqqEvkkGpIPUMe4b6c1RgdVNVj4wjmiMw6l6Joh5A07qMf2p9o4zNZi0uLxgTvnq5HVWhJjX2q/a1kyp6TGjS719sXCmGvmGYSFRVuBYZHIJ/LGdk6IE4ojN6ZXv8fMoFoT7nnU5sdBzd0uP+kM9P8zbfYlJZyHj+3t8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpEv79GWsAtEYR6mWYG47vMfZA+xIMTxer7otjrtlmdRl/S5qmfSlS7Lkqcq?=
 =?us-ascii?Q?RK8V2riKGUG8eK+aopneVR7SMP0hBG5XQn01Hm43VdUs7LOKlrnfmqWpB1QH?=
 =?us-ascii?Q?cWH4l4Isq4GydW6EhXCDiIMDud1RNrkM3bk6FvlrUaJMkWb7mo56LRxCEoci?=
 =?us-ascii?Q?0p2PydNLTinrJEitlS2uuTR4jNRNa6WQvCV8MJQA+BN6OuehpFF/cvMLCr43?=
 =?us-ascii?Q?Z1ZJqj4F6l6Wb/R8tn3/2tWZUf/MVMiPCnVfnQumN4mEpV9w/nDrmX7knAH5?=
 =?us-ascii?Q?CILGfrksc+EyqMLYWCJ0o0LqPu0pg0NoAezNAjUOE3BPUhP8TouyMKb7m6N5?=
 =?us-ascii?Q?MUQvBs3KTeuj0kDPNiMxrhnpy8y92t86lSfM3hjhPOmvW/fGgjd7lpal0rLQ?=
 =?us-ascii?Q?sVxGu/2u6/4DHVbr7VUVn04lzx7uuw9cbzFtfMKULwUP+0go7K4NoE/EbY5E?=
 =?us-ascii?Q?uffzcSNVv7yuRoe7OAKZdJAGjgHtv5YKJGDRqYPCXbAhJizr3WckREKmut4q?=
 =?us-ascii?Q?ud7+5mnyeka8Buh6MDVVdT54nYeiY3AQW4tqjyIrS+Bd9MLK4SYkLJZegiGM?=
 =?us-ascii?Q?RuWPvznXlBPnPlDQ6tBQgfpeL4HDfWBCKGNGmac0InvQk9f1LvCFltGFYzgW?=
 =?us-ascii?Q?+kpav/R/uV6pPOpa7FYAo8Ml7Mwq3Eax86Nh64MROmjXJuGLo89R5guAX6K3?=
 =?us-ascii?Q?zpyVmy0aqoNCN0L/TTXh7K5Q+/H0IjqR/FsiWf/+oKFKFh33qvJr44CIsqSw?=
 =?us-ascii?Q?nRTvaAVPV567sLM1w57MdQrf41vjV8teYFyG/njOmmv0NalY4miEaEd/+IPo?=
 =?us-ascii?Q?J9cq4BOCyu8VUQ9L6u3mhTTvM5KJ3G//jUHYPd6YfGBWnKWKyKJjQva/rPb2?=
 =?us-ascii?Q?iHTxLiH12cKgho/qmTBrQN1geegyFdMHWBx2emFfApKvmA6/mjYWGRPQoHod?=
 =?us-ascii?Q?2Kha8gd5aO2jCa4cEKPUlzMYqRUuw1OPQTRNJRkdWUgnsZjDFocmvZL0v2Vm?=
 =?us-ascii?Q?wYaEUhi6EeN++R9OtVp1Dj16FA0zkwsv5ARB2pyW66hLBQai7Sy361DDPpbF?=
 =?us-ascii?Q?aTEdNDWfrb9XkQqboH8u4WjxLFZeD1ra7M2FaOE58rdhQ6kSXiE31YNFLp04?=
 =?us-ascii?Q?kF+AEEWqVHXzBoE+oGisT7vsCrK2+B55ImgS8TY8U4e9NRaUqxZ5qaW1Hxt9?=
 =?us-ascii?Q?HQEUbp/hShBvXFSBqMNrYiFD5QK8Gieur6T9uW4e0ZAxASoiCOB0583v/uKW?=
 =?us-ascii?Q?Q2H8ZCv1tSjPaJpUfMDl83Zl/2Bg/PxJ+/I3rVx6h1mPYqdfwXVTTZb9fPnr?=
 =?us-ascii?Q?ejuc1i800jol5UNkGYPw0cvEUgbbabg85dbZ4HKCCxt8t4kGAJjQWf1TqkjN?=
 =?us-ascii?Q?zFF+U8zmXVf6d3JaUgtarjQrYezwsfZ5HKgwigepOH5oRh8DoMFh1tZAiXg+?=
 =?us-ascii?Q?ulQDph4DqBWBnVQl699KF8T7AdVkq7QKLH1ZtTAFFMxqQBQnSOyfeBtH1xc7?=
 =?us-ascii?Q?YWDe3aSgAI46cmpopJBZ7l8lBg5ErM4WdZdzc5doXoF+H91u9+Dq/sACfZwp?=
 =?us-ascii?Q?FQU83m0PEBQH2TFMyN4IFRQPkIk7u2jpFzJM8W+TVoxlkjvVaxM7C66LeAJ9?=
 =?us-ascii?Q?rTjlcFxzZqC02wGSStzZc/HarhwVBlYntE4z9NRzpnZKDKpcUHz5YBqKydBd?=
 =?us-ascii?Q?vwTxC0M+PtQVho6lgFvLUv7piEDP+8biBggrpCDTokntH3CgutTogb6jK/7u?=
 =?us-ascii?Q?YylsmtFTgg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Stdo7/E/u5iK87H/1Wx0QZgaGHasKDtjPbO3J+wtViwiMWMoxF0Ecd2oHVFtNggITArCijIQtZI7hO284BrFmg3wNGUKH7nkzmSekcVfQ9LufgxKajn8R2nsP6tkY6hqgJ58+UxI5azSsjW1GpINVk3ZB6/kP0dzvrHx8MSqTcjo6gOA2/sE1jWRrZIEksHO0DyQyv01KZKAQU+WLBHwzECDqKk2cfH1Y79VSYkNgq1FDyWOSCwKbIoA491HXDHoKPwhtDL0iDkzNIZxxtaghfTGEOrCAnqiiBh0T6T0beFc4nsjchcp1Qp5N9upN6JeOSa8KroO8z0ktHReUS5GfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec4dde9-9c0c-4b47-3675-08de7e1a7f6b
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:29:00.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VylcRRo9j9kd4n9JrSTp427OAXzeAD+o5lwZkn5yaw8h6ahrpkCDICav2McI7ERBaLkVKpQtgSVgDrLmY4xHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7072
X-OriginatorOrg: intel.com

Sungwoo Kim wrote:
> A race exists when two concurrent sysfs writes to delete_region specify
> the same region name. Both calls succeed in cxl_find_region_by_name()
> (which only does device_find_child_by_name and takes a reference), and
> both then proceed to call devm_release_action(). The first call atomically
> removes and releases the devres entry successfully. The second call finds
> no matching entry, causing devres_release() to return -ENOENT, which trips
> the WARN_ON.
> 
> Fix this by replacing devm_release_action() with devm_remove_action_nowarn()
> followed by a manual call to unregister_region(). devm_remove_action_nowarn()
> removes the devres tracking entry and returns an error code.
> 

[snip]

> 
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
