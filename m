Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA38BEE
	for <linux-cxl@vger.kernel.org>; Sat, 26 Oct 2024 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729911316; cv=fail; b=KPqOsZPykbZvRYKnFKrmm20rWEQBkXCGNF7cFBWnzIcHIuWSnkAOjP9aPSnu6N6EV25mm+SePQsWTGkeLu0PYQ/vz9J8FQFvw+IrFZ8ZoFZflnK5GeDc5cAyB5DjbpqWfFz+l5sh9ylBIFHGoibzxVcGH3tmzEWkWw9afIE8INs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729911316; c=relaxed/simple;
	bh=opk32jT9+TzY2nkArv7MyX3Wnz3ZNN1YecORJf52YYs=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gAP+vp2ALjmEnneQoAcVkgePfg+znHAzB4CasPyt5ISxx6GY+/9ZKDh1u5I8bWU5jMhUHQYBOmtj7tSqMDfCPyHZq5t4aY1A1x3DAzvM70NuanP7BMie1hDiq1qrrZaWSKsK271uC2C6iY6aDMntjvnHO2NLLN8xgFqTLaqCA2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cs49xEZl; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cs49xEZl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729911314; x=1761447314;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=opk32jT9+TzY2nkArv7MyX3Wnz3ZNN1YecORJf52YYs=;
  b=cs49xEZlMLeKMSIPg+7+b7CG22l4f5jFUzhRvkFpOwEeiyol/OkSyEjS
   cJTUTuApqjf+LH3cWwgy1VWeN1iyGgqVuhMSaIDs0JB0PuoNQ9+2yUcnT
   QV/iy8B22uQZtW8xEOPmAGJfpNulfTcMq48JZTfL5nceQgsiMfMdWN6Qn
   y++3gf2OtnZsrTkiZTf8KZMrhmtryXht5XLMgMmZ5Tak26u8PebDvlMtA
   ueRY6FFGv4VDteqcMMSIE0ZFEZKi9LAVvzgySNRTdhm0TeqtxqVVreuQY
   H+0HIA428WskEn+2iKujX7nxHfp6DfgD/BOErh9D1wprViKEAVRle4IhS
   g==;
X-CSE-ConnectionGUID: shX9KUr1TQCvxCrtq2VC4A==
X-CSE-MsgGUID: CnsY/yqQRbW3zZtgjrPp8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="55002463"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="55002463"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 19:55:14 -0700
X-CSE-ConnectionGUID: JlN2lB9MSIOmZT5ZJjaNiQ==
X-CSE-MsgGUID: rr2Fwcg2TvK8OF53s5D+uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="81239026"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 19:55:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 19:55:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 19:55:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 19:55:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHZxt3Qy0JgKyhmcn/s/xX7CRd1mm8VbxF644PqUqJHK0FB/QLxLM6oNWtgDx4QJNE/wJt4KMHb5kbg/6NW5wD7org937jxFekP+oSDwKOV8uXRAWq9yZgBoPqsjHvNBW5elXb0WJs5kHfQYvl67MoMnQLGORhkqvdGftuTbHgcbjwMjYxMoiec0cRf6sdZ4Pc3HCrH4Wo3AGtYn2VnLkmlHKN7a5rr36NH4uSeCUIQOOQamxMRAZRV02N+a/S8r/b3SC1Y3cWOXA886eJBBRw9xCUS6ER0Dmxbb76W+uXCYGMPoTz74/G7dPvRcHY+1/2PMMLyKKJ3sxzA4+tHEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2augCXD9awVt9sKfaO+2acGip0mXuo3KyzpakLJsPg4=;
 b=IB1Qk/s6SAFqddJqb6ESLOs97LcxtFvdsEvqBKHOQnW4fmhaDiTPl/GwGjtY4eVZJOgi4Uj1PuAE4yETPMieuVM13vg6UNPW7PZJOVZL8GKEKtE797dT55GQROMAmfGIeaGjJFtLccDtgRXY9EaxLYokd7OWFJN7RGs5qsfLtOjd2iwJZ4bXqM1deDtvDavupQw0G4MvzEyoe57hg0U5Z26e0kff7yqSsY9pFErEYXr978miWRA82RqqpI/K2S/0DxKCseZ0HUviLazkKFIQOHLsBpcaOxqbmjF/Vp7ULP48eLU9ZUaEan8pVsb4QTUiNH2c/U55nmF4EBqVMnI0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Sat, 26 Oct
 2024 02:55:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.018; Sat, 26 Oct 2024
 02:55:10 +0000
Date: Fri, 25 Oct 2024 19:55:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, 'Dan Williams'
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: RE: Why does cxl zero-label command fail on my QEMU CXL environment?
Message-ID: <671c5a0c9bf80_4bc22945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <TYRPR01MB123355935A2E90A320934E3ED90432@TYRPR01MB12335.jpnprd01.prod.outlook.com>
 <671c10af9a6f2_10e5929496@dwillia2-xfh.jf.intel.com.notmuch>
 <TYRPR01MB12335AAF060E579DB251E4D6B90482@TYRPR01MB12335.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYRPR01MB12335AAF060E579DB251E4D6B90482@TYRPR01MB12335.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: f05d82c5-c9a6-4c61-f641-08dcf5699b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LKbPiiV4V3osjb7eH8bTSf98gddXm+CRSKWxTUUyDi+QXMcLYwPpxkl+80vG?=
 =?us-ascii?Q?hceReW/ap2kS7w0MAqWatq8ojK78nrcwRlfR83niwGFyO3mkxnWchAVPXx58?=
 =?us-ascii?Q?L1yZwz/i5OCglJEA/MGpEjosvYEmAHV3d54RMmXuJTzRRwQaZ1KDrx1Wt91H?=
 =?us-ascii?Q?xc4DivF5y7HP1peWBEQxmlRoRF4UvnW0+Zfw5MSVT2YVKurvzDyGRwM3VUMd?=
 =?us-ascii?Q?TZzqGtxVnwNgEFsF7WoAz0+onYV9e+/rP3xqsuR8g74Q7WhwtOWo3rXhvbwI?=
 =?us-ascii?Q?/4CmYPyThNDoIAn3VUXDiPmNld5Etf+1dHvl1AGC6xvL91wbLO68ZYnFth0E?=
 =?us-ascii?Q?T5WePhi9hKvGcaJRcX9mnVdrVVYHddcekyyTBfP1YptI8bzn+IJEK/wE/9kx?=
 =?us-ascii?Q?2SHVnAwNohLlUG+V8crjb0vm39IGOJvsAa/s6oVZqeaElkrZs+EhC3ecRXM1?=
 =?us-ascii?Q?RYymKn+mPp8TGLDR+0o6R+P1/n7G+mEZ0N37UfnlkQWuKag2OfAQHJFxEDzn?=
 =?us-ascii?Q?2WBQA4A6GgDhhedokeDS0Fkent8wClchR5+FOYN3H+uS61MuGMkJgZCMzmPU?=
 =?us-ascii?Q?t2Bky+bAdFmCugLfwheDQqaFWo7nRPTmQXQYaS+C8RUnMGUXOxxgheTzbBOl?=
 =?us-ascii?Q?i6+esTxqV4K853TRhPm02MGsOO8tyGgLy+DVTrFdpfRyTfZ6Kwi3cFWQSn3m?=
 =?us-ascii?Q?AhBJKuMu6EciH8AVGEDxlQ3DKyR70jkufwB4xxVvGbzYtwcg2uCKgKaWOPmT?=
 =?us-ascii?Q?l8YsMJ7ox+Yxl9u2HBePyVAJIVISiHkGVV3ATLFMpBdhR5S3NRvzBOKPfbGS?=
 =?us-ascii?Q?AghdB6RtxAMa1XU52YqPYBYhNnpNofMcLiWKWuTsy5zKhvpGRtTRGeqm/Q9f?=
 =?us-ascii?Q?5VOuJtCkCWYAgr+l2FgzAvVlSU1Eio6UPzWPNXMQq6PcdIVlMmwnoplyYuSi?=
 =?us-ascii?Q?aOpGfHBcrNctUggCBniEd04+mwV5YmLeWpqsKF4+EXGnGX+G7KAak17rxM/8?=
 =?us-ascii?Q?4hZ7LQ7PqXBTeJPSmcMmnuiVQrbXDMRgtuziSWrzmKPjz1PSyNlveI8JvSS/?=
 =?us-ascii?Q?BQQbhdPh+vdhw8iIabSNNEpEQNZInORRgyyRDyMMj70xcE61hvovSSizY9VN?=
 =?us-ascii?Q?8kVq1yTQ2XG/2guxViPfWeT7Slpn3AKa0emMSg5ersPp4JM6k2pyUyJmq61O?=
 =?us-ascii?Q?X1B0iwSZlkD/2FJUeEl1YO03HuSYAgs2khIwha1T0LnwVOHa7Dud/YFynr9P?=
 =?us-ascii?Q?fxsmv21JGeSQHtGvGvFH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cjHZlM3MJdiVoiAfaJFHlX5MaKhloW661CJyS8QFrITlD/tr1jB5/zj8Fhj5?=
 =?us-ascii?Q?KRgHCI8Tw34e3/WW1RYFpl1zMi6+o+1p0RqT8geNLyAaS6TNZGsYnNpU03uX?=
 =?us-ascii?Q?FyJdDIBs/uvIrk0oHDYLuZShxxrGBV7GPOTUj7qFJD6L0yB5DeV17wa5XUtv?=
 =?us-ascii?Q?jm19UpnMetnfOUHsQPepjYMOz8V1g/93xUlpUrSBjXMt5DO8YCxzCEjnXqGY?=
 =?us-ascii?Q?iAxyMj9aSNC9CXrZXsxKwJy5dWOJtLSzLEZNZ48mNPR2/WyOy5sNCV/n47TU?=
 =?us-ascii?Q?bG5Zbu73F+LWE8nVZEl+vhVIWwdbVNe6WDyzhPoFPyg6fruu9iG1y5+LSme3?=
 =?us-ascii?Q?fjRsarDIG4q5fcL/c69R+Q9+jCLFxPWIyFN63qi7DxaoIjMBY7FkjA9ODn6f?=
 =?us-ascii?Q?R+9ds/m3G3bsJRMRP85aNAjlQC0K/XBlTfQRpeIW997TfY+qGGA2otuTyq3E?=
 =?us-ascii?Q?K9TU63vqUWjO1XGfG2+rRkcgg5kzNgNMcoSNAWObceofkk2znc2OV5fAl9YQ?=
 =?us-ascii?Q?SU70uZmwpmis8+U4jG2Bvr5ij/Q1F7G2t1azxeAJlKJCa9o0WJ5IGoHvYkkI?=
 =?us-ascii?Q?179z7wla61n2u5e3cOsqnQnYtWGQtk9BnIL1FYsoz3M/cqBpy5D3q4kv/xLq?=
 =?us-ascii?Q?p7wThwGoQXl4QPsydlc8jgSj/QDBYOz24RmcEeZ+wRxMQAuvJMXkHweKGJdi?=
 =?us-ascii?Q?bjHx8cudVQ9U5HzCMiYLAMx/Oy1GkZQgYbCI2jNk50av04JolPq5VDKeMMs5?=
 =?us-ascii?Q?11x/wh8z3mOPFaCL+IqhFJkZA6BMczv9VS1qEJGE6T3hZI+JxmMFOknb3MWG?=
 =?us-ascii?Q?Hg+9oLrMz0XhzjVP9ouQd6/dmK77ElIzczoP5RFcBmIY8HrId6hq0hcC3wMB?=
 =?us-ascii?Q?E3Ys32PKER6DpuXgtV2dIhKJGyE3PILynUmqDccigBNwbFN1C0XK5XHTOW1p?=
 =?us-ascii?Q?gRlSo9mRmR1iS2C7Yk5Dy99z3W7gR59SoByhlqekNDkpYLFp0Y0GHnqjxZsN?=
 =?us-ascii?Q?BejfzD6/XLxE2iEuSPhemPYFtSvZSaKy2NzDiJ6JaW9yUgBnNJEhm5PGs4wI?=
 =?us-ascii?Q?chxO4JIOorCagXZQm4aGsG4/PQ2knM+U9iew22CfwHGHFzPpfzftD9uRaI3r?=
 =?us-ascii?Q?QRn0XiZGKoWtgAO/EIF2dFh5XDx7KFRWs5GKumgULHfe/lyddAshdmow4ek4?=
 =?us-ascii?Q?lHeLqMsXtw4HU4GKStoThCXbt3O/8YamO5ToBiC1ok35aGfEnzLtK2wcEa9e?=
 =?us-ascii?Q?MFgV/kapn3n/SBVvOVJyTBgeUN6Aee7T+XSuOJq2u/of5rQwBRmYoQxbdRjm?=
 =?us-ascii?Q?tO7azcR/ii/6wUOk1ynnYY3oah8w/RcRKFImyUFyuT1dvqWi7qzdySNIk9y8?=
 =?us-ascii?Q?vo103bqhRkCdsnWAQyhShzX8pWw7tSRqyKx8HF+1Y9PNZB5eCeCHnwhZSURX?=
 =?us-ascii?Q?rP+4KiXW002vxEUU5/F27zJvlariZjK1VTJyRpK6UMoP6lrLnFQNqEqzvBv0?=
 =?us-ascii?Q?Ku1F6YD909UO9T4MuhKT8pDT2IKb8PcuuyTV1kwJNpG13wjJDmsCcgRAAaHQ?=
 =?us-ascii?Q?bIBf+aNgRtqxNcjIpkuW+k2ARvKSQk1vy8y4Pve1lHsdiVGEqQfj5HjgntYn?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f05d82c5-c9a6-4c61-f641-08dcf5699b2f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 02:55:10.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZS9xnfCLMSKgbEginwNKhdl2CcF+cBM4wPG8PYpRj4UaJ2atIcZbydyI7RULc5bUkBwN/mSWAW8HSHZAbpkxmPdvFRmKa9dDvLWpAO2yYmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com

Yasunori Gotou (Fujitsu) wrote:
> > Yasunori Gotou (Fujitsu) wrote:
> > > Hello,
> > >
> > > I'm trying to execute the cxl zero-labels command for a CXL persistent
> > > memory on my QEMU CXL emulation environment, but it fails with the
> > following error.
> > > ----
> > > # cxl zero-labels mem0
> > > cxl memdev: action_zero: mem0: has active nvdimm bridge, abort label
> > > write cxl memdev: cmd_zero_labels: zeroed 0 mem
> > > ----
> > >
> > > In constrast, ndctl zero-labels seems to work correctly.
> > >
> > > ----
> > > # ndctl zero-labels nmem0
> > > zeroed 1 nmem
> > > ----
> > >
> > > Can anyone identify the problem?
> > 
> > This is "by design". Once the memdev has been registered with the NVDIMM
> > subsystem then the expectation is that label space belongs to the NVDIMM
> > side where it can be coordinated with namespace management. The ability to
> > write labels from the CXL side is mostly a debug facility, not a provisioning flow.
> 
> Okay, I understand.
> However, I suppose it might be confusing for beginners.
> It would be nice to have a document, like a beginner's guide, that explains which
> command to use in each situation.

I agree, just the small matter of finding someone to write that guide.

In the PMEM days Steve wrote a book about using PMEM [1], and I found he
is also producing similar content for CXL [2]. Not sure if this specific
command submission detail is covered, but his name came to mind when you
mentioned user guide documentation.

[1]: https://stevescargall.com/books/programming-persistent-memory/
[2]: https://stevescargall.com/categories/cxl/
