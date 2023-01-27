Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4976BC54EAA
	for <linux-cxl@archiver.kernel.org>; Fri, 27 Jan 2023 23:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjA0X4t (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 18:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjA0X4s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 18:56:48 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7D5A24D
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 15:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674863807; x=1706399807;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EERxbh7/0mbapQsmX6rx549Y4eItJsF+jak7vfYwBKA=;
  b=OcMTT00mk1gEwwaoagYVO6RCntDjCWXn1A2Uu0UQVdBPeugo99UodNas
   Xu/ZkCiQdCkJgZ5eWpTHsfJesmFkHLNBcBd5PxonDmJiLMPy679S6WUwO
   PIs894ypeNQko2HtbQr22jadbV5ajDIob2UZeFKl3LTQZVhGzE14tYC1T
   pAa3YzDbmQYObObbaRZW+2DbeYwuIUJyN2fpUM5DjkBSMsY6PAkuAzUGC
   jqpgCot88A1Rvt//ESzY0gjehT0CpSS12IyctLapqCcQNsKnMxsPfC9tt
   +CZAPHfzvbWRqxdklslzVleu8Yzrdrus5pmfuq8bG+oOj08mbLGO0DCtJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391778529"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="391778529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 15:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="805990943"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="805990943"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2023 15:56:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 15:56:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 15:56:45 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 15:56:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0EGNUqGAMcoisrJp5WnNyYoyHtZuXxMuF+1AdV9mCoeHLqsmlfdFoBUiwb7cMX5na4ZunaZRbvGA+s58Lne7gayBJ/7sqW9T7rk5s0FQQxI+vW2DPy5obt93CcnLdfesgZ7jSNU+KOhPlowBfavH2n+Akj8N2Xjx3yv7/lVUM547XTAj9Fy7XBF7yYU7CV1Tg0FGIvSCp1IAVXC+LWBpAX0fMcrxg3zAnGIJyJ/Op3d2yyQsQbMjWcfeDw9aNb/hvyVrluXwifvetU+ajyRrMFuAgDbMDXaNTX5VBjZviz9j7BwODMCiNwzGDbgD9Q/NHo98XKFtv9jk9pXr6Oglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s85w1Gu0u967qRmzP21oCVfxT9olzZ73fYG/i8GB7zo=;
 b=F/pGwv1degdjwIUhNJ133au3C1lxRa16YoX2iO25nA4R8ih364e11uN7r2b0YhtVCS2faU/PXY2pJwtwJQETH1GJahQB/RWwhxwOIw3TyeaEW+48TFA8PzCLk/0LhDwN3g7ghOOjxiPRF6r7YGv1SICxipJ/Kb+vUxPbLPTuQv1Hw+ZKRuvT9kvJRhreICHpbh82ZD1Bx8jpRke+VNDCv1BgYN8DFYyUQG8l1NEmBJz0ZL55d4cLP0HPpTZjDJgRA7Yf6AgK4jvXKitJku4krgVSLfsstRhDO6H+bwHF+/+gmqPf+owd40DrE51bGagnIRs04A+gBHuXuRSmAT+CuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Fri, 27 Jan
 2023 23:56:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 23:56:42 +0000
Date:   Fri, 27 Jan 2023 15:56:39 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 2/6] cxl/memdev: Add support for the Clear Poison
 mailbox command
Message-ID: <63d464b7cb7ff_ea222294ef@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674101475.git.alison.schofield@intel.com>
 <3ae253f32602a62fa7521d5787b1b26b1c808275.1674101475.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ae253f32602a62fa7521d5787b1b26b1c808275.1674101475.git.alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:a03:54::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a8d1c7-8a31-4ed7-a03b-08db00c22374
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ve3q++dmEfztLMHDzgNEfDRKRzkm3wi9UXpZIeYjkiZDwjpD3ZiCEqsMBFPkRffl6VZfDThNJPkMMMGQ/bmsIJsw6eiiStZfNJCqacpqoH4rFLRGaAaKcsjDd3uC6UvG7MIVM/GTpsmlL4ah/aoiwxZfyuDavzQMQOIAEfRuyviW2pZUmoNMSvWeX/R5og+8f6Ic0qo3u7xCsX7gpwt+TkUPIxfXjxqVU6amknCXqUROnU58QMg3nQr8naPK9cC6tQwowEz706WD30Qui6buH4F9DB7QvZ8Tj4j6NcPiJ0lksDwzKJO3aIOAuS1P3jECXBTLSXAKkNG8T/I6oHILzs0wYkU+BQLGxriygwCbCD49x4ZbVTIDe6aYFSSusABs62H44nBFy9o/p5c9bm5Vz0xdsY6WtXgtIx/jxkOKyjvvi4QX6TE1WzTgAg1NbQ7OGnfvOKicA7530oScW/MdiKAqO1PeSATmScJvnN+uWJufkrGG9yxeZodih+XCt+hDDbSg9T+oQOrz0TPlkBxGEhMfom/+EW6ySURcNP8aP8avLWSat00M/A+ep9P9tOTKag1Eivox7I6v+lvPlInNxlMR9QGiu61iB21z7I91z3EgGuLEOjDsp8bRVxEeqjwZgH7B0eNSdgadZgydRM9rXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199018)(38100700002)(83380400001)(26005)(82960400001)(54906003)(478600001)(8676002)(2906002)(66476007)(66556008)(9686003)(6486002)(6636002)(110136005)(66946007)(6506007)(5660300002)(86362001)(186003)(41300700001)(6666004)(6512007)(8936002)(15650500001)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pcVgCkO4Vh/zpdywWvYkV5ZK3tV+TUiNto03Z0WlOzAgMt1/4zWIxxeMn0CE?=
 =?us-ascii?Q?5CnejD7wBGi7PL1pn8LMu2eDtiEoyi+/80Lm4BN02BqOL6fBTDuiuOaPHy9/?=
 =?us-ascii?Q?EZ0WySk/dEZkriI2uNkuNuLBZuIA0s217L0zd1aMXR99ST/ER1Y4b8feYJJI?=
 =?us-ascii?Q?4Q/e9CQFBojxjzAMEF2L4F0o/mywVwbYlV1VY2txAi3B28kChaD4TBoJcClk?=
 =?us-ascii?Q?5CRpdbJ7nrkH5N2fvT45H7/QKFeRv1MFgdnUq5fCRTR6kT/tucN9GJw6Bw4O?=
 =?us-ascii?Q?zc2QNPCfm6vmBBg7uJBunR1d50Y3OZW6Q92ECJkPujzFtEMrNdzNjI/+ydmG?=
 =?us-ascii?Q?JO+DSIC4lFM0KQ/UQRHHw8jsaH/2BgLF0GW1nbzvxAcRr3IkjbX+OZBOnEBh?=
 =?us-ascii?Q?J2yI6OYYAhvISlq+S/wQEKWKlRyvLcHoxmoj5la9iOylnRt3iHRebWzqlu4O?=
 =?us-ascii?Q?wwAb3aY3U901bTPffcqp9yRs1Oam70tnRs2DXDZe2aWagmFqW+J5iE22G7Km?=
 =?us-ascii?Q?+ZRG9LjUcikPC+QMWq50xBpmIQ6cSCtculu4AMct2lzLR1qtHoYQVAXfnns7?=
 =?us-ascii?Q?gz3WXxsP23zVRXhOaJbpobSyCxoUayvxVB2PcO6zztF6CC2rImzKO7yyvcA0?=
 =?us-ascii?Q?xvnIokV41cHFnoSliZqR4l4/wg2HQrR3EVwsxjyprtNE7wWPIcjhfwRiSxhf?=
 =?us-ascii?Q?vXh8HsN/NWVhWNDn0h6pVVFEB/2u1WOHGg/5jbQwkJkQOQA7jaFcIeBJnptp?=
 =?us-ascii?Q?DNtI0xgLUGh5tKjPf1NAUOF1KzfNtdZZaohJsK7Av+M2Joy5wDZ8LY3bJW6t?=
 =?us-ascii?Q?W7bIxPmMqoAl+CHHxpq8z0ajuDEiAXrmmdnOQOcP1nuBuV3j3Vc5e7KkfLIH?=
 =?us-ascii?Q?wAAHvjZ2sUZMY5T/RK9SMo4EzXegomHpU4/+Hs7NkeiCFHWi+2dsCriIQQBo?=
 =?us-ascii?Q?+xXc5rlgUMX9kFPdk3CN59GgU5TIc91u++qUfQncCrSKuOTXSR+sn1YzNmHV?=
 =?us-ascii?Q?/WJzEqLtNd1Pb3AU+KgcFZrv0a0xhT6zCw4R6fnoudh6tzxIYGXMxh0LzP0W?=
 =?us-ascii?Q?3vA5Gs5MEQ3tS1Xw8lDCg/yRu1asW1bABkBmR5ELyjGn2aaCUwaETF0r5Qx9?=
 =?us-ascii?Q?KdVZyCLpIoP3rFXuUnCKnCtnfDSDTLR/lUrMxP/vJ6rvS5qIvgZriiuK5YYJ?=
 =?us-ascii?Q?0nduhVy22kRB5wD/+yj3EdQTLmgQ5VW+m1Fp4F/eNNWW40/JRgH8E/7cXWXx?=
 =?us-ascii?Q?uVM4qB6l6+SqkQm3iP7R0VIcrR6RFNppP+gMKiBBBTlRQ3tHThrArTgof+Pn?=
 =?us-ascii?Q?nFy3ckiPxNb16fkGXpe8VI7v+KoWRo9Src1cfJsDfSgL5OlpGrcsotY55TZT?=
 =?us-ascii?Q?W6+n4C6Tw6YocIQA7wh9FsDhT6nQXj8gXZGkcuJBmQHtPnikqUplNfkFvOnO?=
 =?us-ascii?Q?MvmaRpoxGMNX79AdLbLvY9Q2LRZkUW72rFj8GSbhW7HHo620pyowUY9ygrKU?=
 =?us-ascii?Q?5pTNRh+eK7n+shDf1i70VKNcbNexq3RWFfF4aXQvO0Z5BV1pSdhft0djd2Ys?=
 =?us-ascii?Q?ooGJJzNmxCzAVg8evZcsh6Z4JCYL/Gi5scsBe+J3sYoKUrf4tAbASTRG66aB?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a8d1c7-8a31-4ed7-a03b-08db00c22374
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 23:56:42.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TPBOygZ6S8KF5qYvKbRug+ju7K7AVE2uzepySADBuhMyN/thNx0vstZ4fC79ARBAnoKTFaxzV+CyFc8AIogntJS91fUjoY5J9Xcl7S5xbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices optionally support the CLEAR POISON mailbox command. Add
> a sysfs attribute and memdev driver support for clearing poison.
> 
> When a Device Physical Address (DPA) is written to the clear_poison
> sysfs attribute, send a clear poison command to the device for the
> specified address.
> 
> Per the CXL Specification (3.0 8.2.9.8.4.3), after receiving a valid clear
> poison request, the device removes the address from the device's Poison
> List and writes 0 (zero) for 64 bytes starting at address. If the device
> cannot clear poison from the address, it returns a permanent media error
> and -ENXIO is returned to the user.
> 
> Additionally, and per the spec also, it is not an error to clear poison
> of an address that is not poisoned. No error is returned from the device
> and the address is not overwritten.
> 
> *Implementation note: Although the CXL specification defines the clear
> command to accept 64 bytes of 'write-data' to be used when clearing
> the poisoned address, this implementation always uses 0 (zeros) for
> the write-data.
> 
> The clear_poison attribute is only visible for devices supporting the
> capability when the kernel is built with CONFIG_CXL_POISON_INJECT.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++
>  drivers/cxl/core/memdev.c               | 57 ++++++++++++++++++++++++-
>  drivers/cxl/cxlmem.h                    |  6 +++
>  3 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index e9c6dd02bd09..7e4897e7bc05 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -438,3 +438,21 @@ Description:
>  		inject_poison attribute is only visible for devices supporting
>  		the capability. Kconfig option CXL_POISON_INJECT must be on
>  		to enable this option. The default is off.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/clear_poison
> +Date:		January, 2023
> +KernelVersion:	v6.3
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Device Physical Address (DPA) is written to this
> +		attribute, the memdev driver sends a clear poison command to
> +		the device for the specified address. Clearing poison removes
> +		the address from the device's Poison List and writes 0 (zero)
> +		for 64 bytes starting at address. It is not an error to clear
> +		poison from an address that does not have poison set, and if
> +		poison was not set, the address is not overwritten. If the
> +		device cannot clear poison from the address, -ENXIO is returned.
> +		The clear_poison attribute is only visible for devices
> +		supporting the capability. Kconfig option CXL_POISON_INJECT
> +		must be on to enable this option. The default is off.

So unlike error inject, this interface leaves me cold because it is
changing the state of data without coordination.

You might say, "inject poison also changes the state of data without
coordination", while that is true it is expected that media can go bad
without warning. What software does not expect is that memory could be
put back into service without coordination. A memory error wants to be
cleared by the agent that currently owns the memory, like the page
allocator clearing PageHWPoison and putting the page back into service,
or a filesystem restoring a file that was previously quarantined.

The only way this interface can proceed is if it can assert that the
poison to be cleared is not mapped by any decoder which makes the owner
of the memory the administrator using the sysfs interface. That limits
its utility.

Inside the kernel the expectation is that the core-mm or filesystems are
using facilities like movdir64b to atomically clear poison without
needing to hassle with a CXL mailbox.

This sysfs interface can move forward but it needs the idle checks and
locking before it can issue the command. I would also have an eye
towards skipping the mailbox call on architectures that have poison
clearing instruction like x86's movdir64b, because as the spec says:
"This provides the same functionality as the host directly writing new
data to the device", so just try to do that by default. However that can
be a follow-on optimization.


> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 226662cf3331..4d86a4565c9e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -197,6 +197,51 @@ static ssize_t inject_poison_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(inject_poison);
>  
> +static ssize_t clear_poison_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_clear_poison clear;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u64 dpa;
> +	int rc;
> +
> +	rc = kstrtou64(buf, 0, &dpa);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> +	if (rc)
> +		return rc;
> +	/*
> +	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
> +	 * is defined to accept 64 bytes of 'write-data', along with the
> +	 * address to clear. The device writes the data into the address
> +	 * atomically, while clearing poison if the location is marked as
> +	 * being poisoned.
> +	 *
> +	 * Always use '0' for the write-data.
> +	 */
> +	clear = (struct cxl_mbox_clear_poison) {
> +		.address = cpu_to_le64(dpa)
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_CLEAR_POISON,
> +		.size_in = sizeof(clear),
> +		.payload_in = &clear,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(clear_poison);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
> @@ -205,6 +250,7 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_numa_node.attr,
>  	&dev_attr_trigger_poison_list.attr,
>  	&dev_attr_inject_poison.attr,
> +	&dev_attr_clear_poison.attr,
>  	NULL,
>  };
>  
> @@ -225,7 +271,8 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  		return 0;
>  
>  	if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT) &&
> -	    a == &dev_attr_inject_poison.attr)
> +	    (a == &dev_attr_inject_poison.attr ||
> +	     a == &dev_attr_clear_poison.attr))
>  		return 0;
>  
>  	if (a == &dev_attr_trigger_poison_list.attr) {
> @@ -242,6 +289,14 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
>  			return 0;
>  	}
> +	if (a == &dev_attr_clear_poison.attr) {
> +		struct device *dev = kobj_to_dev(kobj);
> +
> +		if (!test_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON,
> +			      to_cxl_memdev(dev)->cxlds->enabled_cmds)) {
> +			return 0;

Similar comment as the last patch with respect to the command enabling.

> +		}
> +	}
>  	return a->mode;
>  }
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 862ca4f4cc06..adcbd4a98819 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -441,6 +441,12 @@ struct cxl_mbox_inject_poison {
>  	__le64 address;
>  };
>  
> +/* Clear Poison  CXL 3.0 Spec 8.2.9.8.4.3 */
> +struct cxl_mbox_clear_poison {
> +	__le64 address;
> +	u8 write_data[CXL_POISON_LEN_MULT];
> +} __packed;
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> -- 
> 2.37.3
> 


