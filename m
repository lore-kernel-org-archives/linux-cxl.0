Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C71C25B4E
	for <linux-cxl@archiver.kernel.org>; Fri, 20 Jan 2023 17:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjATRiW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 Jan 2023 12:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjATRiV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 Jan 2023 12:38:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D2DBC3
        for <linux-cxl@vger.kernel.org>; Fri, 20 Jan 2023 09:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674236300; x=1705772300;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+gQkDeOCV0Y1aXBWzjeV4Vfv2LB+kIpEkc+3nhqol88=;
  b=lcrrGgWvx2YNQZiNbcqd337KtbIvT4DqdWYQdOG4twF8r62UP+9dXvZb
   5qBUeNpGpgfeL5ktqe8+getLhHppdj9wdZ/ZbqPbhBoTk3CwtuUoCT9hA
   fNRrcBkDDUVLoF9uihKHrGMpQdhl1WZstP/A0a8Ospv2Efxd+G8dvix4x
   uhAG73S8k3dRzZTSSwNYBM3Z5h3F0q958isjdzcEPZBJNGBogu+n19HdK
   LLLkpth2e2E5tCvxtVcnlLCRnHqxTTiGa1vABiRIxiQFt6xkLKdWsz5fx
   uqeQJN/NN3Y6rURBit1ioi0/bGwBR7gkel0bXrAHV8qS2d8Nx3UMpbH4g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="324330026"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="324330026"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 09:38:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="724028194"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="724028194"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jan 2023 09:38:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 09:38:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 09:38:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 09:38:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jy7SjxNJpADyX/PzsmKpOZYPIQzuo/9tA+hUs+kRXBi6tO+vR+kaWaECbcCfXffe5F8KKQd9/ndXUYgMsUIKehOSE+InoUD1+pv+lBHq+3EYjc78uf/YEV7bPTp68Ge9/DtCM0YDBzjMvFP/ledpndZ+/17mwaon2ZwQ+IKdeeSQvwJMQrGrm0F0g29IB83wp7+uIOZ1k2W9uKtncyE2nOiB3PEFKe4YfTeu1Pjbu5tCu84/sCs25bMzLboxB1Wpmd9FTUxd3j9VKe9jM1dKi8qyAo0bjL6Zj22YBu/rpNlrLMf+NTyNkoCfXfkeRPWkGGzLJqA3ypU8dUZH35BADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsK6FZR+utuOm7G5Qophq/S8FjUUJRk+U7q/xdKU0Ws=;
 b=SQb2l004z4zRAh0wtca7rA82wutNB4xUhi2TYv22mXUR2cqWf6mbKAL4meHgvhtk3BNl+hBGIZzpwGKrvnPQmK4kPX41NeDwXVDfbEYnR0FBk/bDuchs/wE2qvo/+YDHvSpIjCfHv5zg+hGoWRPgHhxpjLyQLX6r/U/jbRzLsPLQd+QQtDD+V8mBxoJzTjaVypBLQIhzsHtmWYmxclNgk0yx8/A2EuNZBYvRqlwNW6Q2Oe3MwDx+QDa7P+9HLYiLlhUXm1bchruet799byhoFJOoWDmHeaQrGmGNVpmA3qiVZd+zJBBy1UFv0sDc2kWhG9+jhPY50lxuqaBtSLfUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 17:38:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6002.026; Fri, 20 Jan 2023
 17:38:15 +0000
Date:   Fri, 20 Jan 2023 09:38:13 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: cxl nvdimm Potential probe ordering issues.
Message-ID: <63cad185343a1_c81f029469@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230113091213.00002146@Huawei.com>
 <Y8Foj/12QNl0C96o@memverge.com>
 <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
 <Y8hG4OyJL7l9oD2f@memverge.com>
 <Y8hJKcy1993SFLLJ@memverge.com>
 <20230119124244.000015b3@Huawei.com>
 <20230119150449.000037f2@huawei.com>
 <Y8oeYfyqNuSIIxCt@memverge.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8oeYfyqNuSIIxCt@memverge.com>
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd81655-3401-46e5-ecce-08dafb0d1c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAxdno+U4FcrMhyr09qROJjqKPwFeGGLGd3P13q9GQJ9W4AHoHT6xFHkegqsww6jV3hkYhP7bazG5yUeZkQhtIlqOVWkZdQGoASOTxknIhvg5+MIqN1AsKEM9k8rIf24MLJHPDIMeZD1ySbp5lw2V+fof5LBJr+jM2SO5/ZvIo+IBlk3Rq54830SYyTAqI6gCAsb+WHnfiZKMc4QhA1Wc5l1t+TF+zOq+KjaDm1Yyv/bucZ1OM6ZrjHKMx54TXaJxqa2wzQPOquTm+YY6F0mH3p0LHmgm+7Kc5bepLhuEXn8b/5lruk8CVqmTNzAYToT+DrUWVMJz9qvXT4CpH6nE8hsOEENAjUU92tR63rFebibBdpd5WlzGA3bRVOzF7pC4VGFSQfQbam8g7aD+l0+BzH4LX0klhtWQ4h48Qz9+g0SZIWigjo0hL0LjoyWUJQMWbFFuNvWZEhfJRBobdJz1JC59BUYbaxMHi0kGhe3anb4fAdcr1QrKGv3WbyhdBhD5T2B086bbrl6xqD34607egAtTkL+AtLY40Nc71PTR3i4cQplkQtCi5nLrvvvBms7yNlnSkENcVY1OXRdf5UgoI18S1kca4ReOCCHjBmDat9bSvTChN9a8QK/SMTEEG6du1yAe+/++/ettG97oNVJ74Bgz7Ec1mEXjjNb0RLawWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(2906002)(6512007)(26005)(186003)(9686003)(54906003)(6506007)(110136005)(316002)(966005)(6486002)(478600001)(107886003)(38100700002)(86362001)(82960400001)(83380400001)(41300700001)(4326008)(5660300002)(8936002)(66946007)(66556008)(66476007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzFQNHgxcUR2WVE4MHVXajlma0VDKzA1S29nZnVxaE1CaTBSbHlZMkJRUWJt?=
 =?utf-8?B?ZTVSNERWc2w3TXVISGp1QjkrdDRhYkk4Sy9KYWFiRlRSVWErc0s4ZGdnTm1J?=
 =?utf-8?B?eVZSZGtPTUNhRFNVMkRvam02ZC9HR1V3eTBYa2ZBRHBwUVN1L05sYVBVeHZp?=
 =?utf-8?B?NmtMZTVTSy9PbkduNXJyTTZWU2RQdGtaSDVxdERZZzdKOUIwbVNWTHdrcmpY?=
 =?utf-8?B?bUVVTkdOYmZRbmhxbUZpaGwzY3lLR0RFRnVKU1JtY2luL3doZUgrMDA4Zzk3?=
 =?utf-8?B?QjNlTnF5Yk9zVWs2MzdWUVpGOWZnUGN4T29sS3BWV1B4NzlBNFQvaGJUSXgx?=
 =?utf-8?B?dUJuaHpuTCtnNndaamc4NENST3RIRDdvVjRTRHRwRzFRY3JuaVpoTWVYMEFL?=
 =?utf-8?B?NFZ5VGR2KzREQlgzN3dhd3BpcXM3bFgwanNiZmFuRkIySitzcXlOU3Nldjdw?=
 =?utf-8?B?eTJFOC9vNWE0NitkK3BobVk5amtVWkhGaWhwWmsrZDdadGhMd2c1c0tpZDVx?=
 =?utf-8?B?Y3ptUWRHMEFBNVMwaWdJTEZIbWo4dEdzMndmb2Y2QkJkdEVKcXBIS1UzaXFl?=
 =?utf-8?B?dVdUTEs0TSt3TENnVks0aXhxbElFMHNzRnpmM0JUamdaUWNzejcrcTBiR1ZM?=
 =?utf-8?B?dlhOZEVpazVKY3JqazhEZ0M4UGlPaUlFUUxZY3JvcUExaGFpdzQ3YmZIUDRY?=
 =?utf-8?B?WjlTZW9QRCtPaTBza1ZVRkhKYkw2ckNxdkxSTDYvVGRaMXQvSHZEYWFxazFW?=
 =?utf-8?B?cFJldTF2akg1SzNVd2ZYK1JhN2Q5SC96RE5HNjBFTktPbnN5NWpwY2NpbVg2?=
 =?utf-8?B?VzZXb0RqWUpnRkRIKzRUMzVzWHBTenVWU1NXcVkvQjJpenhRencrK2pmS240?=
 =?utf-8?B?UWhXZk1vT0F6c1JjMWVpdGRwWjJ2ejIzOUxLQ250YkNzWUtGUjJWdks4bkZx?=
 =?utf-8?B?TzVudkloZU50b2pzQXg3eVFHbXF1cDVqNGcwRkZxUVM2UHlyZ1ZJR2FjZTlK?=
 =?utf-8?B?SVBwT0wyYXJLS3QyZDUzZ3ZlTzhxUEN2Q1JZZUFzMnRlYVgxMWIrSDJFcWhi?=
 =?utf-8?B?b1IxVFlXcndHbDZxOFNjTWh0aWRHQ0J4WEY0RzExZVd3dXhtV3RZemxzTXRB?=
 =?utf-8?B?TFRaL2hBRVRlYzNjclBIQmJGeFJFS2JCSWZoSSt4VEcxUGtZM0k2bmVYZUtZ?=
 =?utf-8?B?K3B0N29GOUJLcHBkU1R2RmdiM3pEVldSR2M4dmlud1Rpd2tBendCK1liaVFU?=
 =?utf-8?B?RG5JaTdLQ3hqKys4bVdhZGJjV2hhM1hQaVBJa1JTSlQxR05lcjBQTk53b1Ri?=
 =?utf-8?B?N2k2eDhqTnpvVnhGWmVGSk5DMjU0OVVnWUhXRmNyRk5KQ3k0UzVic3VjNml1?=
 =?utf-8?B?YVpDMVhnclIyeXcyemJTaXVsTVV2RVBzR09tMkJBSzVXeXBQZFp0SkhuOXlK?=
 =?utf-8?B?WFBFSndhSmVWdFVRUzRFNmtRVHh3eUNTZ1RibW9iZ0lGb1lQVlBCYkpGTkx6?=
 =?utf-8?B?c2lxd0gySmgwa1c3NUxlY1FiaWh6TnB6SkZFM29STENJclljTDQzY3FpdElk?=
 =?utf-8?B?UFhmbWRsSldYV213elc4RkJob1F5V0xlUDJwb0lFQ3NVYWJVdTJwc0hyaGh2?=
 =?utf-8?B?VTA5czQ1NEpraVBOZzZ5U09MT0tId2gyT1hndVhUNmgrbG5yR3lXemJ0bGhG?=
 =?utf-8?B?L0RUbFc5UmpsMnRyaTJRTVBtYTNIZnNXWWhxVklUVEprY3JxNTdzOUVMR29S?=
 =?utf-8?B?U0oxS00xTjJLMmFKNUh4OWxFd2tlcjJjMTEyNDV2MktwZG5HWmZ6d3FySmtw?=
 =?utf-8?B?eWpwMHpCRlFmamtkS0VYRE9wM1ZnUjhkR2Z1TWF3S3k1Z213YzE5a2QzRERI?=
 =?utf-8?B?MkVQZWFjSHExN3Nlcm5OT1o0bk05dCs5dms0UG5mcUZGZ2tudXZJaEg2RWlv?=
 =?utf-8?B?T003MXBPbkszMGI0SGRteXlzOEtBWWY3RW91NXBENk5CVjZiMHEzcnR2Ympv?=
 =?utf-8?B?NUlUbXNGd3dadG5UMXlWK2UwdE5zNGI1VGxVWkNzTW41b2NqczUzcjZ5MzJi?=
 =?utf-8?B?ME9xaC9YenAzYlJLNnFjcmd2QkZVcUpVRG1SLzdNVXdFcnMxOGRhc1hHTWZH?=
 =?utf-8?B?WmhBeU1kSXM4Nzh5ZnN3T0tBaEpBaU55YnExajQ0bng1VTYxNXJvd3FtWkNM?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd81655-3401-46e5-ecce-08dafb0d1c60
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 17:38:15.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MD0fmZV7hiZWlnYkhfvSuH6uKfwPjoTlZ33q0D2HtIim1kIdVALlnK/DVd3ncYmdZccC6wC5AyLX17lLkpR4G/6Bo7BZJOEeN316zJOJA9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> On Thu, Jan 19, 2023 at 03:04:49PM +0000, Jonathan Cameron wrote:
> > Gregory, would you mind checking if
> > cxl_nvb is NULL here...
> > https://elixir.bootlin.com/linux/v6.2-rc4/source/drivers/cxl/pmem.c#L67
> > (printk before it is used should work).
> > 
> > Might also be worth checking cxl_nvd and cxl_ds
> > but my guess is cxl_nvb is our problem (it is when I deliberate change
> > the load order).
> > 
> > Jonathan
> > 
> 
> This is exactly the issue.  cxl_nvb is null, the rest appear fine.
> 
> Also, note, that weirdly the non-volatile bridge shows up when launching
> this in volatile mode, but no stack trace appears.
> 
> ¯\_(ツ)_/¯
> 
> After spending way too much time tracing through the current cxl driver
> code, i have only really determined that
> 
> 1) The code is very pmem oriented, and it's unclear to me how the driver
>    as-is differentiates a persistent device from a volatile device. That
> 	 code path still completely escapes me.  The only differentiating code
> 	 i see is in the memdev probe path that creates mem#/pmem and mem#/ram

Yes, pmem was the initial focus because it had the most dependency on
the OS to setup vs BIOS, but the ram enabling is at the top of the queue
now.

> 
> 2) The code successfully manages probe, enable, and mount a REAL device
>    - cxl memdev appears (/sys/bus/cxl/devices/mem0)
> 	 - a dax device appears (/sys/bus/dax/devices/)
> 	   This happens at boot, which I assume must be bios related

As it stands currently that dax device and the cxl device are not
related since a default dax-device is loaded just based on the presence
of an EFI_MEMORY_SP address range in the address map. With the new ram
enabling that default device will be elided and CXL will register a
dax-device parented by a cxl region.

> 	 - The memory *does not* auto-online, instead the dax device can be
> 	   onlined as system-ram *manually* via ndctl and friends

That *manually* part is the problem that needs distro help to solve. It
should be the case that by default all Linux distributions auto-online
all dax-devices. If that happens to online memory that is too slow for
general use, or too high-performance / precious for general purpose use
then the administrator can set policy after the fact. Unfortunately user
policy can not be applied if these memory ranges were onlined by the
kernel at boot , so that's why the kernel policy defaults to not-online.

In other words, there is no guarantee that memory that was assigned to
the general purpose pool at boot can be removed. The only guaranteed
behavior is to never give the memory to the core kernel in the first
instance and always let user policy route the memory.

> 3) The code creates an nvdimm_bridge IFF a CFMW is defined - regardless
>    of the type-3 device configuration (pmem-only or vmem-only)

Correct, the top-level bus code (cxl_acpi) and the endpoint code
(cxl_mem, cxl_port) need to handshake before establishing regions. For
pmem regions the platform needs to claim the availability of a pmem
capable CXL window.

> 
>    # CFMW defined
>    [root@fedora ~]# ls /sys/bus/cxl/devices/
>    decoder0.0  decoder2.0  mem0            port1
>    decoder1.0  endpoint2   nvdimm-bridge0  root0
> 
>    # CFMW not defined
> 	 [root@fedora ~]# ls /sys/bus/cxl/devices/
>    decoder1.0  decoder2.0  endpoint2  mem0  port1  root0
> 
> 4) As you can see above, multiple decoders are registered.  I'm not sure
>    if that's correct or not, but it does seem odd given there's only one
> 	 cxl type-3 device.  Odd that decoder0.0 shows up when CFMW is there,
> 	 but not when it isn't.

CXL windows are modeled as decoders hanging off the the CXL root device
(ACPI0017 on ACPI based platforms). An endpoint decoder can then map a
selection of that window.

> 
> 	 Note: All these tests have two root ports:
> 	 -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
>    -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
>    -device cxl-rp,id=rp1,bus=cxl.0,chassis=0,port=1,slot=1 \
> 
> 
> Don't know why I haven't thought of this until now, but is the CFMW code
> reporting something odd about what's behind it?  Is it assuming the
> devices are pmem?

No, the cxl_acpi code is just advertising platform decode possibilities
independent of what devices show up. Think of this like the PCI MMIO
space that gets allocated to a root bridge at the beginning of time.
That space may or may not get consumed based on what devices show up
downstream.
