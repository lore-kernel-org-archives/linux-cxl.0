Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897F2E41C
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jan 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607220; cv=fail; b=kKS2s3q5kKMDpY64rDbnvcsUv7T0ehiTatzS4j/fh1e1FEk3EEGhnz51tbZMy0nof29LCeBs+BFqI8kCPIR7r236BS0TCE9uRoKGLza1G7m5Ns4xwxXZ3IqwihsK6nU2/AzGUa6Y/5e5MICQEoskgwp8OrMttpqOxLwVgxKBb4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607220; c=relaxed/simple;
	bh=oE5IflbmVNqUs5fBHr5exUZBeKBTRVbPt63KEzkV/tQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i7OXhdDtOws2Z0zztc/kXGTn95OWmutK8Q+IksMQVjFc9VJa9KECrmUnUQCg7SoI66BA5lkF7PT1YTh2GE3oeqjrSlwac2jua6H7d66Wvwoo3TVYknAm9xk+pDUXQsB8aomq9V/ay3r3QFYQ39wiEVrLqD909adfmQFIze7l3Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrWkjE7+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrWkjE7+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705607218; x=1737143218;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oE5IflbmVNqUs5fBHr5exUZBeKBTRVbPt63KEzkV/tQ=;
  b=HrWkjE7+MZm3kMit1P6SGMf/hdKM7Ii9qkJt4EZ9+KVKgLhp2/uNHAnq
   FvJwfRwHtSPb9vFkUwQBr3AtzgeCBmGKPFrTOFPVdWYBHO5V7dTpc7Z7a
   w451pVOFSKO9K0fWrsdmA8+xVpIb0doMDERoOm5x6ZTfDPXkAsQkqxJ4R
   TIQZtI03ujaX88euVQCHRcktWkxtHu8Md0zzShGWlufW3xT+SBaCAAJ13
   Bwmh5ARdaPPfTbdMoUNOPEAIwahRhO7h6augUFS3MVEJ12BTsFNAZ8nbU
   AYLhTvBFFlt4ittEX2hYnKwMMfjEIHCUldu2xwgdzK5dklyv5+VkKs/dr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7930095"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="7930095"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 11:46:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="33186555"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 11:46:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 11:46:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 11:46:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 11:46:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 11:46:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwId7daTBlIDgL82tBltc7/vF4ocUD2S7Ly3nSQw2I3BQ5hV+Ur+y0ko1o8tL+C9Sp/1ew1EuEcoPSyYDpRssWCxqurWf9HLhflriWAxGGLb2/8ZY7i8Zt5ZuptbeLQwX6/w2thFGq+UuXm4IEdBWTeS+WVFb3lFevMJem2/l8YtBNnh/YrW/XjXX3IPKhnC/SQvcKuR4/m7gpyijRLIPbQZhCKNcvTZHuOe9PNo1Y/wR/NjT6KQ2x2ZyQ1TC0sQx7lGOI91xfFcWhLsEzDLT/XInZR/2Wv2ZHt+hSXSWYtqiwQzyw9pWftd3L6IPGg+1cPZFfi+qAd8W0LHOnwYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohUQKzT0bslNbf/URjt7aK2Td2wF/CqBJvSRqrSXrfs=;
 b=cmYKcHViYV9ExTffYwDqYDDXemgI2QlhkKYCi5xZKjod/34P/cHg8yRRB3uSvqj4jwhMjStGJVc2uf7iMTs91SHmJEXRamUq2jX5Nev7UzgdlVW/7EmzEsXWvdjcfpfJCyMdmiZxkKbKgQa764wsMmh2eKU0IXODWF90/BjFGe9+HLtNtYHwWZTIvQLA9VFSxgu+rixvEOmLxYk0j7/6KjvFbrD7OZSCTuW/0ED0rk5dt4DkwNqKltYV5We3yhMqS26eCkmoa59smsUcFdljRxdh0XTVVOqhFrBcgRXbRNjAy8BK46mvKKWFJdtGQiqPspB3JzwWe5L5MmlGDVybew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8425.namprd11.prod.outlook.com (2603:10b6:806:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 19:46:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Thu, 18 Jan 2024
 19:46:47 +0000
Date: Thu, 18 Jan 2024 11:46:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Wonjae Lee <wj28.lee@samsung.com>
Subject: RE: [RFC PATCH] cxl/region: Allow out of order assembly of
 autodiscovered regions
Message-ID: <65a980249f50f_3b8e294a3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240113050421.1622533-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240113050421.1622533-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0326.namprd04.prod.outlook.com
 (2603:10b6:303:82::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: f248b992-684a-4779-844d-08dc185e34a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/uq+DL0Zg0C4YEJXvLudKVoCG1/omeB4lYreGMSzAHl8ubPO10WtjX2C4Hr1B0tBRU08JCBB3/uMl6P1VR0m3B9zRnwtMQ0oa1OhdpyakgpK3j20HVfhsykREdCqaXQ/sS68ONUdt659/oZ4UpZ5GHgJRh78FKGPQ/A1+TC3sE6R+49Mpd9Ka0+jb8DTNSkpKu/oTBcF0GN4NlCnyjrVyc05YyJwHMr0UQNj1XPDBtEn6o4H5V+GUtfEsvvUqGh96GqwmNKKBU1+Cq52SENLnbzdX/rMLY1xhRF3kku/2M4F6G1OrcckCsBrb9nXxKAlOK6aeG/ySuFBVUDqC44/Jn/HiYv22/9oOB24yRRUP/8U6Ws5moZcgIbYYYtqDYzbKDakVWHwAHI3AWdpOjwdhOEJIVf4toniJ6M0oyS/MSxihHmbP11CdSHewUjOpSEaQCsiidlggRS4URXfCE6AmO72nZw62M/HKZtQW9c+IzzG7ojSb726fvpkgmUpF551rNW8CBHNwv+GfQZrMjV5oP+vW+n/SVw5IHE3USySsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6666004)(6506007)(9686003)(53546011)(6512007)(26005)(38100700002)(86362001)(82960400001)(41300700001)(83380400001)(5660300002)(2906002)(30864003)(6486002)(478600001)(66476007)(4326008)(8936002)(8676002)(966005)(66556008)(66946007)(110136005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sOByomy5EPwLixKmUaVF+Q+8wylpzX8abUNf61CLKRQWQzg0d1Ma6SMFdrxs?=
 =?us-ascii?Q?2VHqJFoIabkSVdanndWpBCmgzERfemd2H79QEMJsKU+kp99VvCF/QYBM0ZBc?=
 =?us-ascii?Q?Q/nn220RNY+6vBly4rrB08BwUXFSGLv0y/XIxEtHJ2jxp/76MBXuj4UtQ5P/?=
 =?us-ascii?Q?g2QPWi99LIVnPdIaROUFl/q2SgdRsSFXephO0KNNTL/X8opmYvXWQk1lA+UU?=
 =?us-ascii?Q?y/H5S+Abvll/ZppI9CBdezTTXVyv0BBMa9C4AdaK6yXzY8GgxKkYbjivNaNX?=
 =?us-ascii?Q?k4Zv/3Crm0Ch5BelbrnhUxRLV7owYDrOY755oja86s615VJ2lTA8Kw7Kszel?=
 =?us-ascii?Q?xIdosOyGBqHTPb/Xe4kG5D4K36AZUkvhetOCGE/oCd0VviHyVAy5vL7m6r0a?=
 =?us-ascii?Q?fe4zRF1LfezCWENCfBxi5j894Us/YDZgTSEvyKnFf3STuuC0Jm5KSh0IyghB?=
 =?us-ascii?Q?E+d2N1yAWZ/pndAu4wUE+HtK2gn0EIQustDXKmN5Z5x2Nq1rbV4suXP/65xJ?=
 =?us-ascii?Q?zuGsJWMkTyHtp22yCMZpLmC8gBxAukqTJq07dIOc0zdhAszKFUZGld2Q2epB?=
 =?us-ascii?Q?3+N66fHylozo8cZysdM+JgiPaP0gYHAbrLLWYeM/NYEVdMVyNjcTZ8O73+if?=
 =?us-ascii?Q?yi0KK8Fv7UsKADccPp5cudpYX5eZpqNYfsEjSZoRRVxbJKovR5SZD+Dubfcc?=
 =?us-ascii?Q?7SwbQfKlzmcDgzi9xwQs0CuphcwAIXxtQFgYMVZWWgc0BqICYphbSqrZkTuG?=
 =?us-ascii?Q?CsLnzMUnIPPmOLNTVODBcHCq6B+jNiTSL2RYPfMXEY6uQm09gVK37V1d0kmi?=
 =?us-ascii?Q?3AqqWM07icO9Hu7Lf3mJr3TYbWBTJR8es4w0opf9wiJdZ7R3davoy5i//DRu?=
 =?us-ascii?Q?J/pGVcA73xjnK7LJI8lj3UGi/moj5T8lLwti6pXLmJll28G6Og8VK8/eUI3t?=
 =?us-ascii?Q?jW0kHNMgjlWCbpWhBXnqaD4psaNjAtZwKOECXiBCcNttym+prNWJvwwBXo78?=
 =?us-ascii?Q?EmJ5cSX8a72JcdiZ6L++oTLPvysBOmbzP55GTboJ6RewLer09OAre9o0Or12?=
 =?us-ascii?Q?lDYn/QlcdEuN7ST/X1FdF2dgoMpBMWinaozXpxofZjBVqVLxfW9cKOt7ODDo?=
 =?us-ascii?Q?M/TmUnbMsRjIKu9y1DBkkyEb0OB0w6KH5K0SXXfRHfGokmLPyAhn+H5CAksi?=
 =?us-ascii?Q?rf7moy34tOJgKZErYuRDuH/vNM22TZTAP12jPq8z88eGxMAHHN5gtAn17mzh?=
 =?us-ascii?Q?pZqOsCtyjg5d2UrYjDvl3IB26BlmOoIOtDSqjgspacD57/N034+rRqlWLljz?=
 =?us-ascii?Q?r/wAjKgDWPjHQqQjrbLCjpRoHqz1cd+GvqF95uV9I19CtrIHhFWD/nzlaLv1?=
 =?us-ascii?Q?4QhOYax27nWLQ7YaF6Td9qO+3D+FXS6Lr1r8S61Cd/K+Ms/MTj6caOaFrbon?=
 =?us-ascii?Q?rXHYpfy5AxZz3fSf7FxnPVvCtd4OkLVDgmmvgCGBssGPbzLMpj9vLGRF2wVm?=
 =?us-ascii?Q?UYgzed6lKjwHBQXs1SClR1v9VTrGoRjfgFy68yLESH/PSPHwNEHHbneNHz7M?=
 =?us-ascii?Q?uqUdFuFYc79Qji3fVTmXFnFPQPku7fl5kCJJj078ldRBa9dbAUBdAJTSx4R2?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f248b992-684a-4779-844d-08dc185e34a6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:46:47.0192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDzg3o6nbW9JflinKiAsM2/tHQBGH71gvlHWmqnZyLe0D32vMoeXMEpmMYTzGo7vDZFo+aBZz5whcCkRXikUuufnUnsYKL1HNtWwBL4wG0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8425
X-OriginatorOrg: intel.com

A small quibble with the Subject: line, this looks like an "RFT"
(request-for-test) not an "RFC", because the code looks likely correct.
Given that testers sometimes disappear it would be nice to have a unit
test reproducer for this and not require a re-test on hardware.

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Wonjae Lee,
> 
> Here is the RFC Patch I mentioned in this thread:
> https://lore.kernel.org/linux-cxl/20240112092201epcms2p577b3c979bdc694a370e5952edc091f68@epcms2p5/
> 
> This passes the cxl-test suite, so hoping no regression, but it needs
> to be tested with the required config: 2 memdevs connected to the same
> port, each memdev belongs to a different auto-region. Repeated attempts
> should hit the test case and emit this debug message upon success:
> 	dev_dbg(&cxlr_a->dev, "allow out of order region ref alloc\n");

So one of the largest roadblocks for creating arbitrary region assembly
scenarios with cxl_test is the inability to save and restore decoder
settings.

The patch below adds support for recording decoder settings and skipping
the reset of those values when unloading the driver. Then, when the
driver is reloaded, it simulates the case of BIOS created CXL regions
prior to OS boot.

We can go after even finer grained cases once the uunit effort settles,
but in the meantime cxl_test can add auto-assembly regression tests with
the current topology.

With the below you can simply trigger "cxl {en,dis}able-memdev" in the
proper order to cause the violation.

-- >8 --
From 5839392a3dbb64dbbac0630d930b1f48a8ef7ea6 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 17 Jan 2024 20:56:20 -0800
Subject: [PATCH] tools/testing/cxl: Add decoder save/restore support

Record decoder values at init and mock_decoder_commit() time, and
restore them at the next invocation of mock_init_hdm_decoder(). Add 2
attributes to the cxl_test "cxl_acpi" device to optionally flush the
cache of topology decoder values, or disable updating the decoder at
mock_decoder_reset() time.

This enables replaying a saved decoder configuration when re-triggering
a topology scan by re-binding the cxl_acpi driver to "cxl_acpi.0" (the
cxl_test emulation of an ACPI0017 instance).

    # modprobe cxl_test
    # cxl list -RB -b cxl_test -u
    {
      "bus":"root3",
      "provider":"cxl_test",
      "regions:root3":[
        {
          "region":"region5",
          "resource":"0xf010000000",
          "size":"512.00 MiB (536.87 MB)",
          "type":"ram",
          "interleave_ways":2,
          "interleave_granularity":4096,
          "decode_state":"commit"
        }
      ]
    }
    # echo 1 > /sys/bus/platform/devices/cxl_acpi.0/decoder_registry_reset_disable
    # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/unbind
    # cxl list -RB -b cxl_test -u
    # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/bind
    # cxl list -RB -b cxl_test -u
    {
      "bus":"root3",
      "provider":"cxl_test",
      "regions:root3":[
        {
          "region":"region5",
          "resource":"0xf010000000",
          "size":"512.00 MiB (536.87 MB)",
          "type":"ram",
          "interleave_ways":2,
          "interleave_granularity":4096,
          "decode_state":"commit"
        }
      ]
    }

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c | 268 +++++++++++++++++++++++++++++++++++
 1 file changed, 268 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index f4e517a0c774..3f333d6a57be 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -44,6 +44,9 @@ struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
 static struct platform_device *cxl_rch[NR_CXL_RCH];
 static struct platform_device *cxl_rcd[NR_CXL_RCH];
 
+static DEFINE_XARRAY(decoder_registry);
+static bool decoder_registry_reset_disable;
+
 static inline bool is_multi_bridge(struct device *dev)
 {
 	int i;
@@ -660,6 +663,153 @@ static int map_targets(struct device *dev, void *data)
 	return 0;
 }
 
+static unsigned long cxld_registry_index(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	/*
+	 * Upper nibble of a kernel pointer is 0xff, chop that to make
+	 * space for a cxl_decoder id which should be less than 128
+	 * given decoder count is a 4-bit field.
+	 *
+	 * While @port is reallocated each enumeration, @port->uport_dev
+	 * is stable.
+	 */
+	dev_WARN_ONCE(&port->dev, cxld->id >= 128,
+		      "decoder id:%d out of range\n", cxld->id);
+	return (((unsigned long) port->uport_dev) << 4) | cxld->id;
+}
+
+struct cxl_test_decoder {
+	union {
+		struct cxl_switch_decoder cxlsd;
+		struct cxl_endpoint_decoder cxled;
+	};
+	union {
+		struct cxl_dport *targets[CXL_DECODER_MAX_INTERLEAVE];
+		struct range dpa_range;
+	};
+};
+
+static struct cxl_test_decoder *cxld_registry_find(struct cxl_decoder *cxld)
+{
+	return xa_load(&decoder_registry, cxld_registry_index(cxld));
+}
+
+#define dbg_cxld(port, msg, cxld)                                                       \
+	do {                                                                            \
+		struct cxl_decoder *___d = (cxld);                                      \
+		dev_dbg((port)->uport_dev,                                              \
+			"decoder%d: %s range: %#llx-%#llx iw: %d ig: %d flags: %#lx\n", \
+			___d->id, msg, ___d->hpa_range.start,                           \
+			___d->hpa_range.end + 1, ___d->interleave_ways,                 \
+			___d->interleave_granularity, ___d->flags);                     \
+	} while (0)
+
+static int mock_decoder_commit(struct cxl_decoder *cxld);
+static int mock_decoder_reset(struct cxl_decoder *cxld);
+
+static void cxld_copy(struct cxl_decoder *a, struct cxl_decoder *b)
+{
+	a->id = b->id;
+	a->hpa_range = b->hpa_range;
+	a->interleave_ways = b->interleave_ways;
+	a->interleave_granularity = b->interleave_granularity;
+	a->target_type = b->target_type;
+	a->flags = b->flags;
+	a->commit = mock_decoder_commit;
+	a->reset = mock_decoder_reset;
+}
+
+static void cxld_registry_restore(struct cxl_decoder *cxld, struct cxl_test_decoder *td)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
+
+		dbg_cxld(port, "restore", &td->cxlsd.cxld);
+		cxld_copy(cxld, &td->cxlsd.cxld);
+		WARN_ON(cxlsd->nr_targets != td->cxlsd.nr_targets);
+
+		/* convert saved dport devs to dports */
+		for (int i = 0; i < cxlsd->nr_targets; i++) {
+			struct cxl_dport *dport;
+
+			if (!td->cxlsd.target[i])
+				continue;
+			dport = cxl_find_dport_by_dev(
+				port, (struct device *)td->cxlsd.target[i]);
+			WARN_ON(!dport);
+			cxlsd->target[i] = dport;
+		}
+	} else {
+		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
+		dbg_cxld(port, "restore", &td->cxled.cxld);
+		cxld_copy(cxld, &td->cxled.cxld);
+		cxled->state = td->cxled.state;
+		cxled->skip = td->cxled.skip;
+		if (range_len(&td->dpa_range))
+			devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
+					     range_len(&td->dpa_range),
+					     td->cxled.skip);
+		if (cxld->flags & CXL_DECODER_F_ENABLE)
+			port->commit_end = cxld->id;
+	}
+}
+
+static void __cxld_registry_save(struct cxl_test_decoder *td,
+				 struct cxl_decoder *cxld)
+{
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
+
+		cxld_copy(&td->cxlsd.cxld, cxld);
+		td->cxlsd.nr_targets = cxlsd->nr_targets;
+
+		/* save dport devs as a stable placeholder for dports */
+		for (int i = 0; i < cxlsd->nr_targets; i++) {
+			if (!cxlsd->target[i])
+				continue;
+			td->cxlsd.target[i] =
+				(struct cxl_dport *)cxlsd->target[i]->dport_dev;
+		}
+	} else {
+		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
+		cxld_copy(&td->cxled.cxld, cxld);
+		td->cxled.state = cxled->state;
+		td->cxled.skip = cxled->skip;
+		if (cxled->dpa_res) {
+			td->dpa_range.start = cxled->dpa_res->start;
+			td->dpa_range.end = cxled->dpa_res->end;
+		} else {
+			td->dpa_range.start = 0;
+			td->dpa_range.end = -1;
+		}
+	}
+}
+
+static void cxld_registry_save(struct cxl_test_decoder *td, struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	dbg_cxld(port, "save", cxld);
+	__cxld_registry_save(td, cxld);
+}
+
+static void cxld_registry_update(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_test_decoder *td = cxld_registry_find(cxld);
+
+	dev_WARN_ONCE(port->uport_dev, !td, "%s failed\n", __func__);
+
+	dbg_cxld(port, "update", cxld);
+	__cxld_registry_save(td, cxld);
+}
+
 static int mock_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
@@ -679,6 +829,7 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 
 	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
+	cxld_registry_update(cxld);
 
 	return 0;
 }
@@ -701,10 +852,43 @@ static int mock_decoder_reset(struct cxl_decoder *cxld)
 
 	port->commit_end--;
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	if (decoder_registry_reset_disable)
+		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
+			cxld->id);
+	else
+		cxld_registry_update(cxld);
 
 	return 0;
 }
 
+static void cxld_registry_invalidate(void)
+{
+	unsigned long index;
+	void *entry;
+
+	xa_for_each(&decoder_registry, index, entry) {
+		xa_erase(&decoder_registry, index);
+		kfree(entry);
+	}
+}
+
+static struct cxl_test_decoder *cxld_registry_new(struct cxl_decoder *cxld)
+{
+	struct cxl_test_decoder *td __free(kfree) = kzalloc(sizeof(*td), GFP_KERNEL);
+
+	if (!td)
+		return NULL;
+
+	if (xa_insert(&decoder_registry, cxld_registry_index(cxld), td,
+		      GFP_KERNEL)) {
+		WARN_ON(1);
+		return NULL;
+	}
+
+	cxld_registry_save(td, cxld);
+	return no_free_ptr(td);
+}
+
 static void default_mock_decoder(struct cxl_decoder *cxld)
 {
 	cxld->hpa_range = (struct range){
@@ -717,6 +901,9 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
+
+	if (!cxld_registry_new(cxld))
+		dev_dbg(&cxld->dev, "failed to add to registry\n");
 }
 
 static int first_decoder(struct device *dev, void *data)
@@ -738,6 +925,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *port, *iter;
+	struct cxl_test_decoder *td;
 	const int size = SZ_512M;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dport *dport;
@@ -767,6 +955,12 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		port = cxled_to_port(cxled);
 	}
 
+	td = cxld_registry_find(cxld);
+	if (td) {
+		cxld_registry_restore(cxld, td);
+		return;
+	}
+
 	/*
 	 * The first decoder on the first 2 devices on the first switch
 	 * attached to host-bridge0 mock a fake / static RAM region. All
@@ -795,6 +989,8 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	devm_cxl_dpa_reserve(cxled, 0, size / cxld->interleave_ways, 0);
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
+	if (!cxld_registry_new(cxld))
+		dev_dbg(&cxld->dev, "failed to add to registry\n");
 
 	/*
 	 * Now that endpoint decoder is set up, walk up the hierarchy
@@ -837,6 +1033,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 			.start = base,
 			.end = base + size - 1,
 		};
+		cxld_registry_update(cxld);
 		put_device(dev);
 	}
 }
@@ -1233,6 +1430,73 @@ static void cxl_single_exit(void)
 	}
 }
 
+static ssize_t decoder_registry_invalidate_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	unsigned long index;
+	bool empty = true;
+	void *entry;
+
+	xa_for_each(&decoder_registry, index, entry) {
+		empty = false;
+		break;
+	}
+
+	return sysfs_emit(buf, "%d\n", !empty);
+}
+
+static ssize_t decoder_registry_invalidate_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t count)
+{
+	bool invalidate;
+	int rc;
+
+	rc = kstrtobool(buf, &invalidate);
+	if (rc)
+		return rc;
+
+	guard(device)(dev);
+
+	if (dev->driver)
+		return -EBUSY;
+
+	cxld_registry_invalidate();
+	return count;
+}
+
+static DEVICE_ATTR_RW(decoder_registry_invalidate);
+
+static ssize_t
+decoder_registry_reset_disable_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", decoder_registry_reset_disable);
+}
+
+static ssize_t
+decoder_registry_reset_disable_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int rc;
+
+	rc = kstrtobool(buf, &decoder_registry_reset_disable);
+	if (rc)
+		return rc;
+	return count;
+}
+
+static DEVICE_ATTR_RW(decoder_registry_reset_disable);
+
+static struct attribute *cxl_acpi_attrs[] = {
+	&dev_attr_decoder_registry_invalidate.attr,
+	&dev_attr_decoder_registry_reset_disable.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(cxl_acpi);
+
 static __init int cxl_test_init(void)
 {
 	int rc, i;
@@ -1377,6 +1641,7 @@ static __init int cxl_test_init(void)
 
 	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
 	acpi0017_mock.dev.bus = &platform_bus_type;
+	cxl_acpi->dev.groups = cxl_acpi_groups;
 
 	rc = platform_device_add(cxl_acpi);
 	if (rc)
@@ -1446,6 +1711,9 @@ static __exit void cxl_test_exit(void)
 	depopulate_all_mock_resources();
 	gen_pool_destroy(cxl_mock_pool);
 	unregister_cxl_mock_ops(&cxl_mock_ops);
+
+	cxld_registry_invalidate();
+	xa_destroy(&decoder_registry);
 }
 
 module_param(interleave_arithmetic, int, 0444);
-- 
2.43.0
