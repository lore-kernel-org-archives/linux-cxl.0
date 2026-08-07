Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A54A199FAB;
	Fri,  7 Aug 2026 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063043; cv=fail; b=oz7GI+DgXolJZGsvvnRQXfzhu/+sW04dCIOxY0mmkdEkkS5rUG5G2JxnD062mTWtand6DUHDf3Udh0oAzH5vZMd5jDwJI3rsBWbc8KniAemXD0RFjTMM/JsIWRKNXv3BPCj1PSVqjNx0X9qLeKHSW/9ueYpxWiURa9unItpJ7ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063043; c=relaxed/simple;
	bh=to80hCi5OQYemxHeZ2KGpHlxVolLg8/t0c/VVevGBQ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FONrE+MpyCuNzrTwl0ArVtiZfajozAFjakK2AGmFCNRIAH1A5hLz9aM4fO8znLhkwBkL8X1tF+2+aiXC8GhFnFpOBaQtPYS26y7N1uVay5DxqF4fMMoHvuoJou+XW/LgJ6P3BIygcXxdfL8aY1AV4GZeYIsjj4TcUxD1HajsVBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NX5n9gtm; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NX5n9gtm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786063040; x=1817599040;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=to80hCi5OQYemxHeZ2KGpHlxVolLg8/t0c/VVevGBQ8=;
  b=NX5n9gtm+gTpkVEyb/+K9LI1kXRRptHTIBaK8aXtr0dSdz83Gx+/mdIa
   zEv2x52MVe2/Bnz2YvOWfRd6k1woCbD5xw+SItWpCSFA0iubzUVZGdUuD
   WHRzBwrnZI07aTqymBj08pveHEvEfWvAJ/voVNdLWd0eNCgleeRvp5fLB
   RJofZICapCGLQWybXxQAnnCY99Mo+qdIQSUlafhT4Y07eH8zN6GgUYbOV
   7wg6qM6EO2nrmEIgk7G9lS7yt/OokFbSqfvyaTMuYAb5AymtN/46/BIV3
   EIeHBVNDe3M75AK/BcC+UfDvNkLGfJ3Vi3zqObtfY59XubLKXBDA/8kJb
   A==;
X-CSE-ConnectionGUID: mQFWOPFlQX69WCHqD891eQ==
X-CSE-MsgGUID: A4ogmwJMTKmlVbddFyNsSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="104072410"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="104072410"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 17:37:20 -0700
X-CSE-ConnectionGUID: ONMWPX6cSUGgqXCMFfyo8g==
X-CSE-MsgGUID: FWhHzbiKTSGdpd3W+nT8kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="292143452"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 17:37:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 17:37:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 17:37:19 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 17:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTps7ZogsYIxATOYaM7hadgooX5fK3HoaAjxd0zQiEENcIleS+ssTGnhKd/+8L16iod/jMCATYR1l99pHxSeLSRrL7YCbe0X31xna4IwF9wdFJ7ElFdA/hySKDW62ChQr2u3kw2aT+4q11yyCvi8Cc+fB+31G3LViJdHHAf747ndaBh/T9+gMwG8SsYwsaaAspRJGt93RkMrrR0oASGN5sA5Xts13LlXuuupfjfAqkJgW/BthXPwxA0vzTPyokU8pud43AB4fnpNLOD8mkFZD6W3YuNpS2zfu+BJ01QykQpaAyNnkTLNxjP56bgbqvqdeqM4ft5GRRqNlVmh9PkXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj5wDgu7IJRnQeaurNUel+B2ejguU+W2BDKRALxn5lc=;
 b=scAGDUVqorsH3iaZP9OROmgJime5YfhrJp3Q38ckCO6zXuixXwDBUxzm7CEG3xtFZjpsiV3qRVXRHWx0C/1PwUpDhpYlogBV9l5OOk+lx9LFuTljBaRHp8HwbMKmoHuTPE0lnx2na070HAJ8j6YosEgNzCZBoJZfFdxky1OCPgyQp9APgM+N01q1IBP2WXjOK7dEJHv0XJvoEbNQa3Xnu1Uovg0wHoEVwCON5yya6TgMgig5CMFz+0Z+40f1/MiHmPe1NQrInpmyghignn9mo7+Z2Ixm9GVGBbFugkCdqWp2VXd8zQ/s77IZXtbRRJjjmph+R/KBxI09Ct1a1Kp2TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 00:37:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 00:37:11 +0000
Date: Thu, 6 Aug 2026 17:37:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2] docs: python: abi_regex: catch the right exception
 for a bad regex
Message-ID: <anUotMOFSJpBTtJh@aschofie-mobl2.lan>
References: <d57d3ddc0d7d883bd61ad07c6d3969b622fd446f.1786058698.git.alison.schofield@intel.com>
 <20260807000345.86D851F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807000345.86D851F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ2P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ac010e-9204-4241-7f6b-08def41c04d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|56012099006|4143699003|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: dcNvLENGxkoH6ZnEWls3EM+muQS48g873RDNlfhFtr0H0e+pAnoXWS8xzhSE+Wkp0IF42UbVYTkTWLyDtyC6sW+Enkr/SgTxr0eeb/AhZpqAB/D3NOv4HTmXwYy/yIPCXlYIIU8wGX8KMu4t5ijisA3ttTOD7eDKRedj6ouqAuLOLx4AnUimLtBNxEIwD50Ru/habBQyIe4yZ+FGFAnWG5RUwN+cPU1mFgEcms2uldeTW45iR+rooVvE8Y6Cd6/I+X0b0gphNNM50iDPfhULmnn0jOTAtO6ZiNpjDivXL2eSt2gi2Ul45NOFl3rPgadjzazMZ+32du0KB6kzMnMSELaDmQJSpguOymaeujjdoeOLDgvd6/lEU1XLAX85EPt/3sPnkw+4x1ZQ7vbb1B3KOkfRIhjaMnRRATeGFPLkPDtnHV/wsTY0F1jxt/ZhGKVcFM2aNCQLXQgSRfNSf450kQmHsbnoMn1m2A7rir5oobAXDto1TvC7an6KQI3vZpnzBrX5PXXQ3rWMJMAvA3a3FTU346mYsr0GJR0IfcDRorerxYoqVvHaZJuyTG6A4NuaQh+/ElJsEdtASDypxVkSXT0AaqVuHsrZiyyP/r01csw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YpYOqJtRE7EHszf/e7+oz84vf0VzwfnJLsk7TCsz0HkDjVbT60o/jxk3XB?=
 =?iso-8859-1?Q?vgRMQtg5MZN3CGnW6M+2KKZWgG+dx0PitNF+/aVKQsNALdnicLR2d2PumS?=
 =?iso-8859-1?Q?UTJUJZh5wivILi5SUXkFfWyqIkNHqRg3ETzSBpUqfu2620n5jPCCHDDxyL?=
 =?iso-8859-1?Q?xhBWtf3/UAqqbZQI1m4YWBvJQmYZ0GdwbKEeQ2RQ/z+6RYlHa1Y49kYmzB?=
 =?iso-8859-1?Q?+cv+HT6y89qpp3J/6IFxwmNLSWFoSqUeX1mUqyp4iQYJyYvaT8jnoCgAcs?=
 =?iso-8859-1?Q?YEASaheqjExfoWZuPtUYu9CVoGPSHMrpUGao9CmkWeZLJVSQr8nWmN+7BM?=
 =?iso-8859-1?Q?jGBvTHC02Oxx+YSuiWYB54wQ3jqryfTUl5mboMlfsDTypuzBHjaGETG0ow?=
 =?iso-8859-1?Q?5CoP/ZeoNvCB7cPzKH0gaV0AOdPF78dgEuod9248ncFVIF2VtQlb3dBhRM?=
 =?iso-8859-1?Q?4LKyzpdyb1LY8FGq65oyZYT+1L771Pk4sdLbuy/+d259vrsTRAFMZ1yic7?=
 =?iso-8859-1?Q?IthLtFEdd7TOksYbxilk0ITzs+xoIEJsjjbcX5tSDU1vQKNZ3sWJr1CMDz?=
 =?iso-8859-1?Q?JYPeZiuNgElHNO7zIjTxvHuDg1/LozZFdKSwqJUgeL0b1VxZs2+9P+6wnz?=
 =?iso-8859-1?Q?Q9jKZ7cYotQxKjih8VgLXii78tbTe0yfgLuvrCQHd81zBYX/sGVden9glW?=
 =?iso-8859-1?Q?wKHmmUXS2f7FoINKjwzL3vklq0N8tgwjHgLo5vjaUMkWpPtR2zVKh4MsC1?=
 =?iso-8859-1?Q?sBP5I8v7XJqHMQHESc8kZcds1L5DNEkPtoEg4O+kZbOxIZLJsHtHyIQXZE?=
 =?iso-8859-1?Q?VDxf9X/HhoRHsuvV2vZx72EWBtw6pzt6Zls/u+Euu1SyElKmYZCUaRwCeq?=
 =?iso-8859-1?Q?TrY+WTbokRlt7fAQU25dNzZQSR1ucIQe52tLYVXeXDwf21/8UdlU6FcQ28?=
 =?iso-8859-1?Q?Lc9cQq3KDFuRJgF6NKzgsoaXsZRVs/Gz13IoCETKjIaNkxvECdk+Fg0nU5?=
 =?iso-8859-1?Q?1l7nnAGKgeL0SIVj7ZPSAdzt9a6WFw9U+DQvpRhBQrP8ioKc1etrCbtHcQ?=
 =?iso-8859-1?Q?lTsRwtV2l79Gqd4KzXXUBvrI1XSgW6gnU0kXB6kkzWv6Ppfbi6WPx4K9DX?=
 =?iso-8859-1?Q?0hD527hoR67QdThYZjGkv9VHXHUuer/fjxcQtjcInYyQ/Ci5KcSsuI0xk3?=
 =?iso-8859-1?Q?qoS0Tv5rbIiaDBOW8wwrfdyCCSX6IvXYqmD/jt4L9St1DCjDIz1DXaQx+/?=
 =?iso-8859-1?Q?ksgEBkKx+OjY7woXQLJMoVixaMw26bSJIQkNFCGfvimVgpK6aITfpu5uJv?=
 =?iso-8859-1?Q?woT2GbGju8M5ZjgnYb70469sKKGTdg6gUjbY3Rj1FpCP5pQgOQpu6gYNFi?=
 =?iso-8859-1?Q?Lg8BHEZpVSjJB3zxu4pZ32/QGiW/Xt8xhHWf7/9nzt7bZt93ivB+Ir/6Ud?=
 =?iso-8859-1?Q?nJTuJGUqh5kWYCYVMIwGwYPSslP1dKUbcRtAKrPsSAX2RhlBr0J6xEC014?=
 =?iso-8859-1?Q?IFUX2ibNvZkf3WB1sP+pXhxfftdZz6QxKuH5FFPxRSAjO8kQbhi16GqCEb?=
 =?iso-8859-1?Q?jdMLxZaHUcMHrM5cOk2tMMEt+qy2a1BS2kZU20T6MekYy24Ihm1lySPaKp?=
 =?iso-8859-1?Q?y8HP0KQdmhnT2xFi8HYZUDHqQJONN6YUEbsws7cXleLLtNSvLH5ukrKZTt?=
 =?iso-8859-1?Q?B7sQ3lp1xZZoUwfifPjZFM7v935OAOiDr06F2GQPNH7J/KbZhUBrxLwB3t?=
 =?iso-8859-1?Q?bsdNljzxYuNJduqi0cOYTox5mJb+7VskKKzUCyzVpuebQPlsMc0A0T4rcG?=
 =?iso-8859-1?Q?1KRGghwqugKSzOOyQJTScAojIH1C3SI=3D?=
X-Exchange-RoutingPolicyChecked: UM0LdEi3WUpAaoL79wLKwZTpT5SnVCLSxf+B/41Nx4Y+/sZZFr5KhV3XOZyp/0xsPzv6apUfcY/9wrxLoybVgNnZLoB8M8hkx5RS/7v9arWEHbkCHOSoBG6bmPan9xNtEMXPFQbA+YMOMjMQ8pkCRn7tRfcrF++7dvjhfI66hLKNX35XdwSqG1hFa6r7Cs9pZr1j7TBS78DSeMWMtgeJHjb06KhG5HQkInPGMVednYgpw01o1r4f2z5OOSCqCqyPVbfxn51ZXKhbOiMc6sJwxeI+PkjJ3F1JpT0HuC4PbZh7kQdgULW7zcPEv3wlMp/q5SBh8YdmLJu93zBhdFbsaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ac010e-9204-4241-7f6b-08def41c04d2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 00:37:11.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXbHgUuW/dqvM6b/59xlAqSJNaADagOqN3Q9pv82i4xSMgiwrWQV9Bk0n0SAr3M8axQ38HztdClBY1fFZed11w5751c+1d9WAAT0YHYgs7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6020
X-OriginatorOrg: intel.com

On Fri, Aug 07, 2026 at 12:03:44AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch replaces `re.PatternError` with `re.error` rather than catching both, directly contradicting the commit message and exposing a misunderstanding of standard Python.

It does indeed catch both by simply using 're.error'.

re.PatternError is not a separate exception because re.error was
kept as an alias for backward compatibility.

So yes, a bit of secret sauce not obvious in the commit message.

I'll wait a bit and see if Maintainers want a respin with a commit
log update for that.


> --
> 
> --- Patch [1]: [PATCH 1/2] docs: python: abi_regex: catch the right exception for a bad regex ---
> commit ed601931671f151d8ef4f1bbd0e817520a34f3c5
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> docs: python: abi_regex: catch the right exception for a bad regex
> 
> This commit updates the exception handling in abi_regex.py to prevent the
> script from aborting on invalid regular expressions. It aims to support
> both older and newer Python releases by handling regex errors correctly.
> 
> > Older Python releases raise re.error, while newer releases expose
> > re.PatternError. Catching only the newer name causes the scan to
> > abort when an invalid expression is encountered.
> > 
> > Catch both names so the scan continues and reports the remaining
> > results.
> 
> [Severity: Medium]
> Does the commit message accurately reflect the changes? 
> 
> The text states it will "Catch both names", but the patch replaces 
> re.PatternError with re.error entirely. While standard Python uses re.error, 
> if newer releases actually exposed re.PatternError as stated in the commit 
> message, wouldn't replacing the handler cause newer Python releases to abort?
> 
> > diff --git a/tools/lib/python/abi/abi_regex.py b/tools/lib/python/abi/abi_regex.py
> > --- a/tools/lib/python/abi/abi_regex.py
> > +++ b/tools/lib/python/abi/abi_regex.py
> > @@ -155,7 +155,7 @@ class AbiRegex(AbiParser):
> >              if self.search_string:
> >                  if what.find(self.search_string) >= 0:
> >                      print(f"What: {what}")
> > -        except re.PatternError:
> > +        except re.error:
> 
> [Severity: Medium]
> Is it intentional to only catch re.error here in regex_append(), rather
> than catching both as described in the commit message?
> 
> [ ... ]
> 
> > @@ -194,7 +194,7 @@ class AbiRegex(AbiParser):
> >  
> >                  try:
> >                      self.re_string = re.compile(self.search_string)
> > -                except re.PatternError as e:
> > +                except re.error as e:
> 
> [Severity: Medium]
> Does this __init__() block also need to catch both exceptions, or is
> replacing re.PatternError with re.error sufficient?
> 
> [ ... ]
> 
> > @@ -223,9 +223,9 @@ class AbiRegex(AbiParser):
> >                  for r, s in self.re_whats:
> >                      try:
> >                          new = r.sub(s, new)
> > -                    except re.PatternError as e:
> > +                    except re.error as e:
> >                          # Help debugging troubles with new regexes
> > -                        raise re.PatternError(f"{e}\nwhile re.sub('{r.pattern}', {s}, str)") from e
> > +                        raise re.error(f"{e}\nwhile re.sub('{r.pattern}', {s}, str)") from e
> 
> [Severity: Medium]
> Similar to the other locations, parse_abi() replaces the exception class
> instead of catching both. Does this match the intended behavior?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/d57d3ddc0d7d883bd61ad07c6d3969b622fd446f.1786058698.git.alison.schofield@intel.com?part=1
