Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0026C7EE23
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 13:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjEWN5f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbjEWN5e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 09:57:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CD7E45
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684850223; x=1716386223;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=buhuuU9cJaI5/yTeD0Wr4NiLyP/pce16hjrTCWasjBs=;
  b=mN941WSMYKH6vETteAC7Zer1LUeIh7Otw1smUhuFQU0x1ChJffe/K/ct
   4ssz3HKCIJ942Gy0fbPgaCx4Xiy76Iu8qIUTkGjYDLmRsGLDNAzOtieIK
   rWL2/L3731r1D7d2wo7oWvW1vxG3+xZADGXcG0De/DCpX1PemFAARtcV9
   iZCWQ4C8pSEWM6xBbJg5KHp688f/aof/2LCpbKCkkLGaMoIIGba+j+O9h
   J6dwk9fy+FtcO2Wvztzb4CrFUNIaiwHxtieYiiFP5eCHSEQK4+MdNfFP4
   Y81cjLVRcJcVbA3qK8k9J2grp+BecNS+9vZsNyvZa1QlrZYhQPEaJ7d6T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="350751599"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="350751599"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 06:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="793730252"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="793730252"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 23 May 2023 06:56:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 06:56:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 06:56:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 06:56:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 06:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njj58/WsRuZeAUyehuQaNj1/CepRXxO7ro+w+a+yR8hzeEn9SYCGZ8xtUilLBpDY0Zmme+LvVrotHaA+ylcXI3fE3CRWR7NI/suDCGUxYqsPOYSK9dqkZmo03RvRR0GGSoAfrRb/celD2ta2m+oGuky3DlKHf7C2emznOf6xqQWvbruTf3QEmPLNX7wf0mlBzZpZu22ZSDL87Ii1p6mYVx5jWQgO8bGPkuFr+KplgruLFkM4KKKkr9Q8HtLWAkPzc9NNrx+kXlBy9GqO8RORXtOahSEBqYzCrFjHXgNmEd7cK/g2G/31Qbd3DsGVioZ2fJ2wvIKPZ9vuEw6UceZYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuWrJ5qOBv1B7lCdW8IvdpzIFkCR7SC1o22cCzhAXBE=;
 b=KT5kdGf5WyuPEAMcrmWR7tRkbAwZUqhlOQ0cv8N6P9vlPpscaH6obK9hJf/9UrPLC0brudhHsSUdey/7ih675DR9l4Bp3RyXUUupMzAuIE6Zp0LVEiTG5aU3GpJ2kLeBUsmJif9ICWnFDaWSmqtO/mVhBSwKaOeq3xfEL+r6I0+phle7qwVkIoid3AqghqTcqX/RxAH6vhu5o4P6OsiJr9oscmyglAJTkmNQovPsLXe9yVBYJfIE2qm9NIOPMB19YuPrRjF2vhuvjb1zluVvno5HfUd9WfcZKq6AunO8sJREqQo675PzpP2YRMYUioSmQtbKERat8NVca+EaTGHWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB8417.namprd11.prod.outlook.com (2603:10b6:208:48d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 13:56:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 13:56:33 +0000
Date:   Tue, 23 May 2023 06:56:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v6 6/7] hw/cxl/events: Add injection of DRAM events
Message-ID: <646cc60990976_16581529470@iweiny-mobl.notmuch>
References: <20230519143043.30191-1-Jonathan.Cameron@huawei.com>
 <20230519143043.30191-7-Jonathan.Cameron@huawei.com>
 <6dc139cc-ec19-196f-017a-cb0a415af3e5@linaro.org>
 <20230519164533.0000436d@Huawei.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519164533.0000436d@Huawei.com>
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 23985e7e-a4cf-44aa-8d41-08db5b95842b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcSeI+FhG01fPZD30GC3w4qKVkmT/IHEjSq2bJTwb8KW7q1fOGX2V0Z3EgcU54VX2pvgXZxf1IHjL9gzArcDMUaJyR9UPMGxXcnyWzkN1xwG/HMt/wy6uVSHDt+SYmnmkMYnNkl3TSguJ3DECzUKnas4IRBHpxhPJVmWrCU0MerhKCTcEaZVQJjLMXiAi+ax/YSN4++g2mO4TrY72vzKuPagT9DwEop8ILIOcdNaSRVacLwFZ/B8azurNksblW2LGIGPMvWhX2h8oOwej9/AAUhYiTdGIYcGAHvzai9vLx9CK3UwDS54BN4qTXqH6EzHdyF3Hl4Xx0MnAGt30SXd4Z1bd0EE0Yyvdt1F2w3C9e2iqrCF7xAoFBV72YcHIv+6E8PIvIwNAeh75MLU/htQl1b7ma9K69TQ0gM/IlyxJOOeQ+oSBdh80xPV1tmOeO/Zi0xHoXFfOSGUakRHFKmeUwDqORgc8JsBB8RpzGb9WOdtRyGGCwLJLaiCQRtOYYvL+lEsPsxrrxsqf/2iFOy0WcSARyLOhzO7sBH0cLKiCumXshmtwOnM9OlMbOe2El50
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(26005)(186003)(53546011)(6512007)(6506007)(9686003)(82960400001)(7416002)(38100700002)(44832011)(83380400001)(2906002)(6486002)(316002)(54906003)(6666004)(110136005)(41300700001)(478600001)(66946007)(66556008)(66476007)(4326008)(86362001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Y0KzfPOLnjNTSuHn2eD9Q62/ZGj99N1BtT3TqCReTRGoBYWRlkZtKlNiag?=
 =?iso-8859-1?Q?taqxdY43WMb9lS2NZr6lqqJJxUkL+1kgmkRi6bKAB35VoIn4106v9Tjn5H?=
 =?iso-8859-1?Q?EZ6hiYDuGcNt3Ncly+V7CqwY9I2IMrM1m3UZXR4gG4YhB0cSZnEhecJoBr?=
 =?iso-8859-1?Q?2c4cf+65eJpq77DGb1WyGS/a1xt6J8Jf2TMeRq33e1a3iJxxWzCWoyuUoW?=
 =?iso-8859-1?Q?uFAm7dWhQ3I/48K0tvfDEkfgv0u6GSWp8Krzay0aalQlykFYmUkSjYlyht?=
 =?iso-8859-1?Q?bBHyN00LyXd6E4dpN26RPmmSNbwEVb8cyD3IfcvjPMUAmeMvG7PEoxcm+e?=
 =?iso-8859-1?Q?VZfBCYFt+QUGeRxwFE6lbbsnt5iKgwMXeYttFwolmKx6xlyvrMXHXHTlqz?=
 =?iso-8859-1?Q?zfS/N9GSsYEMYWW5kASOdS62fordTjAYpITs9yIjZN3xvjzLzYHYqJjPJ/?=
 =?iso-8859-1?Q?oX0Zkzma1HdnCyFQpZSiK6ZmF9/v2A+KyXZzcuxgqyIfI8ZQK20NUkl3kV?=
 =?iso-8859-1?Q?pK//+qAQ7j6nDUmVEjnpFWNUbj4YHXCb7Tj3ZgW/lHgD8aitTZn0+oGU/A?=
 =?iso-8859-1?Q?D+mxPlAbF3OohRVTJ6TI/c9kxa1bLeLCxbQRVM+OsBca5+PH7KP3Dv8k/D?=
 =?iso-8859-1?Q?j8DbyKvWADI7TPNiDuf20SGgU+ZakazsKmDknWz75WxTXthyqkfnM2tL9Y?=
 =?iso-8859-1?Q?TooWtKDAeKIG4G3PdcHUVex3dJWYYFqI7blOkM+EPD/Kl9JPxC/9z5tMxS?=
 =?iso-8859-1?Q?iBU1tR1qSMVnUmwkS/xdPzLhi5A4FPsaxspUIA/UgOnA9DRhzE+IcKBQRg?=
 =?iso-8859-1?Q?+3dyNoz8UwZsVmTV8sJfk0K0KJPon6pAunHbzr0O/jK/CnMzsTP9WDzoCC?=
 =?iso-8859-1?Q?IiX3irzZnrJeU4HyKVNaGjD2ty9lBC2ylDUSfRJleUxHLOtUvWJ8iddowI?=
 =?iso-8859-1?Q?FLclYl3gW02PFiHNenybXwKglSlO3XFto8v4xjwa+E+FbH7JelgV8sNt8I?=
 =?iso-8859-1?Q?JmmHIAzyjMAlG2kz65VK5I++CGXPSrzEYOGhxdtkUR8X48g70GKElodR8U?=
 =?iso-8859-1?Q?wLNIWIGbCtHPGxGa9d8ggzwaBVOPjB/ScAuR2Mj9xYvT8IWZyVfPVjcB/T?=
 =?iso-8859-1?Q?sP3XSw10ZUF2YA+Ec3NmEf1TqxI8l9DiI3dPs+N5iFpw4innRFQaxX54Ti?=
 =?iso-8859-1?Q?M/yRgJjMd2UYWt+k8298CdJwR5Bb8etSXNR9kDI6anzHl4ZcZDUMFTwDz4?=
 =?iso-8859-1?Q?tMFK/AODWDM7u9MJNlkCkHrGqohLh6OR5lxuUdxDQD4FAT0QLP1sRx9Pr5?=
 =?iso-8859-1?Q?MmlkuYZf1SFYd7A1zdULxvcND44VXOz3FZemGAXaGgS6MhOkRNsbzJfF0c?=
 =?iso-8859-1?Q?YWLFaAXgCNktHw7fr5YEMlq034EpCJ/loj9/fG/unAMns5mn7GQzUgy47z?=
 =?iso-8859-1?Q?D7f0GUglVylpeumxEEtOc58Z65nC0sAK1ObX101NXX3hYXWjuiROBuzORG?=
 =?iso-8859-1?Q?2lDYOdaoihE8c63Qft3V9p0V3E3g9Z/5sR2IK51GXdgbGPOTU96b0HIUu4?=
 =?iso-8859-1?Q?vRoLCX3n5kCOIkglVZFYfsZNQVo4ehQXUU1nGX746tCy/cJPhE0Syy5Gxe?=
 =?iso-8859-1?Q?nQoE7PLB4tQltVYBbHJj0lG1eWqxAIwNeA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23985e7e-a4cf-44aa-8d41-08db5b95842b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:56:33.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2uHFoHzKGtbIThxjle5unB4jrCsF4jZyBcF0DutTYF+8Ho51X/Vb5ihUbD1LrcQZJmlRRjhFMzAMhqq1zAzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8417
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 19 May 2023 17:34:20 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
> > Hi Jonathan,
> > 
> > On 19/5/23 16:30, Jonathan Cameron wrote:
> > > Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
> > > provides information related to DRAM devices.
> > > 
> > > Example injection command in QMP:
> > > 
> > > { "execute": "cxl-inject-dram-event",
> > >      "arguments": {
> > >          "path": "/machine/peripheral/cxl-mem0",
> > >          "log": "informational",
> > >          "flags": 1,
> > >          "physaddr": 1000,
> > >          "descriptor": 3,
> > >          "type": 3,
> > >          "transaction-type": 192,
> > >          "channel": 3,
> > >          "rank": 17,
> > >          "nibble-mask": 37421234,
> > >          "bank-group": 7,
> > >          "bank": 11,
> > >          "row": 2,
> > >          "column": 77,
> > >          "correction-mask": [33, 44, 55,66]
> > >      }}
> > > 
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >   hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
> > >   hw/mem/cxl_type3_stubs.c    |  13 ++++
> > >   include/hw/cxl/cxl_events.h |  23 +++++++
> > >   qapi/cxl.json               |  35 +++++++++++
> > >   4 files changed, 187 insertions(+)  
> > 
> > 
> > > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > > index 7e1e6257ce..5e82097e76 100644
> > > --- a/qapi/cxl.json
> > > +++ b/qapi/cxl.json
> > > @@ -55,6 +55,41 @@
> > >               '*device': 'uint32', '*component-id': 'str'
> > >               }}
> > >   
> > > +##
> > > +# @cxl-inject-dram-event:
> > > +#
> > > +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)
> > > +# This event type is reported via one of the event logs specified via
> > > +# the log parameter.
> > > +#
> > > +# @path: CXL type 3 device canonical QOM path
> > > +# @log: Event Log to add the event to
> > > +# @flags: header flags
> > > +# @physaddr: Physical Address  
> > 
> > Could this be a clearer description?
> > 
> > "Physical Address (relative to @path device)"
> 
> Makes sense.
> 
> > 
> > > +# @descriptor: Descriptor
> > > +# @type: Type
> > > +# @transaction-type: Transaction Type
> > > +# @channel: Channel
> > > +# @rank: Rank
> > > +# @nibble-mask: Identify one or more nibbles that the error affects  
> > 
> > > +# @bank-group: Bank group
> > > +# @bank: Bank
> > > +# @row: Row
> > > +# @column: Column  
> > 
> > Why do we need bank/raw/col if we have physaddr?
> 
> Yes we need them. We don't know the device geometry / internal interleaving
> / address hashing applied to smooth out access patterns etc.
> 
> I really don't want to put that level of complexity into the command
> line for a device - so just left it to the test tools to squirt in
> something valid.
> 

I agree.  I don't think anyone is trying to emulate their exact memory
device internals.  However, it does not prevent them from doing so with
additional device types and/or qemu flags to get that behavior.

Ira
