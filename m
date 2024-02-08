Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37750253
	for <linux-cxl@vger.kernel.org>; Thu,  8 Feb 2024 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707433072; cv=fail; b=WJQFEUySNE6+IlFr9RSM6EDXn91xiSSfCVXbILu3EkH8l8rLdtyByU2IDNfjiJTMq9OtAw80pemGDmVgZHfuHQt/mv1NxXuGHScMfOV3qM3WeiFZ9qRfPWp845R9RiUL95w4nV51fV8DYTRAAih/ztPG4XPfa4jSkNHl6nVoy7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707433072; c=relaxed/simple;
	bh=kdAvhayfyWJqa4FAYfOeJljE/BfQSKDTC4UOxqhejII=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VJcp+4VGwylSRiH2Ngnt+tG2Fqx/qX3wTCK+CLsFFuw2nnwfs/DKbH9j5zCIAIGhlr15jx9Fj2JhqMHOMmWeS52XUBP3kMhLUmVBL0kAJmEEIpdtm/H78owQb5K+4DsbKXPwCJrxgxJBlTka4L1VuZIBwZpiYszHYzV1cuNEJO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DETTI6aT; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DETTI6aT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707433070; x=1738969070;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kdAvhayfyWJqa4FAYfOeJljE/BfQSKDTC4UOxqhejII=;
  b=DETTI6aTu93XtOEyGOmo7gpqYEcyfTJ/ptA4YVGoRLnxBXeYOD0BQyXr
   dZEmixoozfqychFWAC6R9jLSFyp4wn4rAwfV3cuOmCtvAVRv4UR4gPolu
   pXTbj/oj6kFoYNPMnUwHX9sjket7fL/hyoTKMdRCrTTgry57f66NGSOgq
   aUkwzbNEa/tTWQTSESf8xmdAlv1auu56jECwgJmW6EB0FcAs3Wxg362MH
   E0hehldsMg3l7cVWkeNzCj6ZJCxVvqtGXvtohjTWRx4ZTl3R9xB9Lz7BK
   yCRsGaWlKVUs5u7UDlKdO6SooJKTDTi4Xefj1n9GaNmUnqRv16dDjjNP7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12416199"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="12416199"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 14:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="39226108"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 14:57:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 14:57:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 14:57:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 14:57:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAYwmqBAcOa1eo1AnlPRJ/UP/gAHoE2GRgL3bv+RHy1e578lfvKQzTckTGFbxC/KFh1I0kbOzlWQ2yzvMtRZnkHhcqI89eGUSXgxQVgX86xoM6tXmRCIe/Wtd7io58wOvWGEq9GL8lGjTAk1jePdUi45LV0HuXZXu7badyYqIl4etFYRpOROXNSIsTdpCVNAlqd8YtB1wkl5mueb7ZrbHhtjJkEKXTj83ldqTjEujOhVR/zb8Mie3UtHQb1kRlmx+du9pB9lTJ/6pVFPVNPxNnwZ7dQ7lJYxQI1Gkufq/ETBYvXWIvN8zccDoeHVN53cCCKCSuwWcXek/t+oNsVvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVLvYxUnaSubeJu0AtYdI7HAsa5k8jRip3AegqS1Zbk=;
 b=HuzLXnQmYGFGBLy95EiFgq/OBNOfv1XGlHM9EDK9BSLBsSvH3WWP1clgLzxkYgEMcsSrWwgLlL7GXfH8sY8o9xldGXJd06X/MsaABYMR8pQfSIMbnfE7Ih889QlWAtqhh5ROLcXZnbwRxryZBOAjvr+R0rNTKWJZMwQa18Kk8YchwRPA3DRNTR5xbi2baZr/YTIvSow245P7n3Ir6yHYZvBkGcj8fcvEJyOSMwNGeEoYaR1uvE4E9rQlYQ1maMezdtq5bIQtEOuVWWxEDeroInTvcUyPuKJwJk6tj4u2Js8ntekJl4iftJIPQioub7jVeEEK06s60Mw8uQqQ5rOYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8402.namprd11.prod.outlook.com (2603:10b6:a03:545::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 22:57:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 22:57:45 +0000
Date: Thu, 8 Feb 2024 14:57:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, Wonjae Lee <wj28.lee@samsung.com>
Subject: Re: [RFC PATCH] cxl/region: Allow out of order assembly of
 autodiscovered regions
Message-ID: <65c55c67ec60f_afa4294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240113050421.1622533-1-alison.schofield@intel.com>
 <65a980249f50f_3b8e294a3@dwillia2-xfh.jf.intel.com.notmuch>
 <ZcU+9BxBD8IRsnTu@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZcU+9BxBD8IRsnTu@aschofie-mobl2>
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c45de6a-7f15-4426-4ff7-08dc28f95d53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tEKy3k+R+a0i8BRKUrAPkqp3zOuAaDByG68DwH2rbkMAaLrfJVv1dl1cCBnH4AmM2BOY/Q4JwpoiGtgx9Uo7UD5UWZ7EPAG2u8Hh6Flogv03wtNYOoPqR+WPLw0/mzX0dvlITzgg7uVY1kp3g/WWQMdUpgTHPGl3T9hZFPZpH5b3kBcq5JG3YeLvCvSTfibQHhGf0kE22HyTOZU70l0KztGdj6HnC2AvILSiCzTvQ3GZUIg0Q97lu4+vwXmTkXAAV3crPQwmBDg19zOpvuCySMUg6WhyJ0xj5XhDy1lR07jt22j5kSB9V4r0P/VOzAj1Katk6usQTzwCIweylBkMtGLhO6is0Z5j5lfwJKBuEHtUcz7hFvHZ6oYt2m8SiBwlTBNUL77cUDD5nDwawIiarDjqG0aAGqF+/tnqfZL2Lth7puY0yOL4WpFoM9mtfOBL193aCFlPyvGV2EJ7XxCKapGuyMp32rE6jORyP4rs5qiePLC/BNisVH/mGKg4+PGFcEO6pXwZ6nNcE/qVI/p2622DY7EnToERo5/LrXT3cl5z5dH3rFcyF/yNiBcoBiX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(82960400001)(2906002)(6512007)(6486002)(6506007)(53546011)(9686003)(478600001)(86362001)(41300700001)(26005)(83380400001)(38100700002)(66946007)(8676002)(4326008)(66556008)(66476007)(8936002)(54906003)(110136005)(316002)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f3ZuhaqrbL23c6md3kGHDjERLROhy4Rbwwx738yzWs5WlwrwrOa7yTbbvX7T?=
 =?us-ascii?Q?a9hzENggCghgV6oevUZvV/LNE39obyBa+FBzQF+uUjNF9gLuaawYhzSS+tkt?=
 =?us-ascii?Q?D0VQXFCrGa2xUVuLyuUujxpDE2DrTDsfxIJGG1aQhfdOnlVYOy8waHgGoQ8I?=
 =?us-ascii?Q?7b6KoXzobJc5cUGv6wKZbv5ktZYlc0ZaEfxp8J5A/rCagyQILeI3MfAttVq5?=
 =?us-ascii?Q?FSDoypck5Gh/0Wv9LDi34NhvFRo0Ua5vBeSQDNb1zy9LAiuHAEuOXggeKn9Q?=
 =?us-ascii?Q?8ggsQ1X82RUs4S4ng8hl5FZivlHP8BxulphwdrkasVPvOsSRaNOZzo1Uay1R?=
 =?us-ascii?Q?rvOpjgdFD2nx+L0R3BT7Mu1HXXTibBVwvudUqmuDhO7M8cTxBZCwtSgymC+J?=
 =?us-ascii?Q?D9S9mTkMSA+d23QD/qJuPSDoHzAfWpWPLSlW7CnUV3ysFJ1bQkedjCaHc/Tb?=
 =?us-ascii?Q?mSyRYACHwF2vuGtsLwVte2S+U5VbT0Eac+dNaRguxU2dMhJuxYOGZO72MS0T?=
 =?us-ascii?Q?lfNsaARZtHHRe+YEHMJHNIAS86s1SB88Z9XJmdpN3F+qqKVvMG/ivUcgAtAj?=
 =?us-ascii?Q?aj1srPRgN4Y8fNb01YCAWmgGwdvYWcldv8AH9b5zB9s9vdUTcgesfzsho9qe?=
 =?us-ascii?Q?FswHJU+ayqZ90HLzGilfR6OcSHI5MTrxzbLmzn2qTLHGX7Vjj0iUBWmAinj+?=
 =?us-ascii?Q?NMpc6jDPRysuOj8lt8yaQrrY9woMMj9EaJpomnk+s5WxYN9T822J0LR6aClk?=
 =?us-ascii?Q?K3wwNT8Kp2L9BoS58CsHkE2Asl2TpnnsLt2bRhcZPN6iV5S0c+3hdJHeuvoI?=
 =?us-ascii?Q?8325dABw8wMBZIcGeDC/biVwUngAJpLYsxwXflHDtpyNZVOuR/JlhlNxPXTi?=
 =?us-ascii?Q?AA7yq4U3ssP9kEwVO3+6saIGmx8rKfL8EdDcdZU7deZXnogk3MVYzarZmIJF?=
 =?us-ascii?Q?eJ3kdA4xguQEi1sAzz+vviHsI+KXXaCUNOT9Penmkx0KzK6ORgQVXDlfAAIg?=
 =?us-ascii?Q?kndZls8mb4BvpJV3Vl9NIWseXFZk1m0gxsvUuzdEoT8nVWa34imMIe/fcWs9?=
 =?us-ascii?Q?K64EOgbzqx4QFjqnLpXgWBBbPV4b41nCfLXKDd/5bOQZXrK5/1D97wyQFkKT?=
 =?us-ascii?Q?ehrVUSjFy3UdiWOPVuvvzXgr/jNatdrrEuV0D41t50GhLABW5lqG6Gr4CqqN?=
 =?us-ascii?Q?SO8ap61bjue3phdVexobycorNWd5IqCdri1Hw5sPVaG2u1BP7Tm6Moma7DIU?=
 =?us-ascii?Q?w/hWmebrIipInJgzIEzJZ2PV9YVRarNUJPScll5kHrjGMuChsQOO0Txv4lGt?=
 =?us-ascii?Q?JUy6RotmsnsJo28LSBmzSNqM4KrdEQNbK+WCGlpjc6z5T6BUW6SVaRXEgxhH?=
 =?us-ascii?Q?Zg2AojQsmCawnQzco018x7f3xkKAea4B6O8DAp5k6PqpBbb2JwGJuxp71V+Y?=
 =?us-ascii?Q?BiY8zKxHVKIIsklfxmKc+upWsLq2hnVMrSPQmp++Ipwb7k0XOB87SEcU6GP2?=
 =?us-ascii?Q?YpCr6IwG2P+uph84pg1wO1rdMgwBRK1jTeTVp0mmmkltKVntR/8WENlb7RgJ?=
 =?us-ascii?Q?o6A/zFNjLovAgcjDDsYb0KeS22+tw/rfjUuy0oLOjW+JaPCIIq8dZbandcjs?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c45de6a-7f15-4426-4ff7-08dc28f95d53
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 22:57:45.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdMuk/tdQvmTZrpH/IIi64Pm0f+tdVvZi3lCCiK8jwN+Rs43cv3K6RPiPoR3ClkWaUJA5rXvZgjbkdeUDwO6Z4/LTjTRX3Kt0cx4DVmopFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8402
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> 
> On Thu, Jan 18, 2024 at 11:46:44AM -0800, Dan Williams wrote:
> 
> - snip to decoder replay patch -
> 
> > 
> > So one of the largest roadblocks for creating arbitrary region assembly
> > scenarios with cxl_test is the inability to save and restore decoder
> > settings.
> > 
> > The patch below adds support for recording decoder settings and skipping
> > the reset of those values when unloading the driver. Then, when the
> > driver is reloaded, it simulates the case of BIOS created CXL regions
> > prior to OS boot.
> > 
> > We can go after even finer grained cases once the uunit effort settles,
> > but in the meantime cxl_test can add auto-assembly regression tests with
> > the current topology.
> > 
> > With the below you can simply trigger "cxl {en,dis}able-memdev" in the
> > proper order to cause the violation.
> > 
> > -- >8 --
> > From 5839392a3dbb64dbbac0630d930b1f48a8ef7ea6 Mon Sep 17 00:00:00 2001
> > From: Dan Williams <dan.j.williams@intel.com>
> > Date: Wed, 17 Jan 2024 20:56:20 -0800
> > Subject: [PATCH] tools/testing/cxl: Add decoder save/restore support
> > 
> > Record decoder values at init and mock_decoder_commit() time, and
> > restore them at the next invocation of mock_init_hdm_decoder(). Add 2
> > attributes to the cxl_test "cxl_acpi" device to optionally flush the
> > cache of topology decoder values, or disable updating the decoder at
> > mock_decoder_reset() time.
> > 
> > This enables replaying a saved decoder configuration when re-triggering
> > a topology scan by re-binding the cxl_acpi driver to "cxl_acpi.0" (the
> > cxl_test emulation of an ACPI0017 instance).
> 
> Hi Dan,
> 
> Sorry it's taken a while to come back on this. I did find it useful
> in testing the auto-assembly order issue as you suggested. 
> 
> I didn't use this one: &dev_attr_decoder_registry_invalidate.attr,
> I just reloaded the cxl-test module to do same.

Makes sense, that can go.

> This I used:  &dev_attr_decoder_registry_reset_disable.attr,
> with your decoders state fixup to set CXL_DECODER_STATE_AUTO,
> and a work-around to avoid pmem_probe failures on pmem region
> auto create. 
> 
> More generally, I'm wondering about the implementation of the
> 'registry_save'. Here it continuously updates during all
> cxl-test usage. Did you consider only creating the registry upon
> user request and then at the next mock_init_hmd_decoder() look
> for and use that registry if it exists.
> 
> Usage would be: 
> # echo 1 > /sys/bus/platform/devices/cxl_acpi.0/decoder_registry_create

You mean wait to snapshot decoder state when triggered?

> # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/unbind
> # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/bind
> 
> And then maybe, for folks who like to acpi/unbind,bind, rather
> than reload module, we could offer a decoder_registry_remove attr.
> 
> Am I missing something regarding the need to keep it updated
> on the fly? 

I can see it being an alternate way, but not sure how to weigh one
approach vs the other. Is the dynamic update getting in the way of a
test case you are thinking about? Otherwise it seemed easy to reason
that the registry is always on, but only takes effect when
registry_reset_disable is set, and cxl_acpi rebinds the test device.
