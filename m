Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078FBC38159
	for <linux-cxl@archiver.kernel.org>; Fri, 20 Jan 2023 05:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjATFI0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjATFIA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 Jan 2023 00:08:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558FE28D03
        for <linux-cxl@vger.kernel.org>; Thu, 19 Jan 2023 20:55:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wjlp3Ql8WYb4B0mSbe9x5cnFdC4DQ4+fvGi1q/Osd1um2Q9MP7hkTFYkiN2XzMST9CZtsMeJra6mg5IhBYGNAwFWPXCgfAPiOa2UAKMo72ud+H/kMubycJwx55pYC6jFUyc1Wx6wyVjwIINZY3wyGc6mmSIH+GxwlLyb4FFl87LXHeaRS6sTzEcMrlrkifTNefrZcAZiLp8RY3jwFRGYBnupNoP9s9CJNmm3rhmM/RR6mJQRzFa4MbCqRQFSlryJFS/DuqH+OuHvXWqyW3ZBOgwGmc7RZvuy4QhRTlE+atrv9Pbh6y8uQ0UXnQLGTfzsqIynCl6RVowJPy7swBz0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49s+uP1F4mc5sZHI6peOqUsUNaOES1YQVXQmYdNeTJ8=;
 b=HNIbrVHAhX0C9K6PMU6QubUdQF+vpzLtJ3tIF8qYpyCLeCiOQrSfnixdSIybE9MORi4itjF+hlU++pTTz9eOhGhvvVIUkLDCqPgr+PE1inmJLfuuSV29dzQPjadRtU7W6X53xGW+Mh0yHnW5WOnHw8ck9gERrRKJWU7yJnPqc+ncUhPtzB82fp7SLveabEpJpqUlrrJyKMoxbHBD+6MJav5ORHnxcu7R+4TvmMc5HVxUv6Cja85WJlZTduWLLQrsKpM3rCNgVUjRwJax7lSNJ//9AkgrWe8QlseHwnsEv7ePA/pMX6UPj5MbuDU7ifTAibr8V00F5KOWGolnSYMY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49s+uP1F4mc5sZHI6peOqUsUNaOES1YQVXQmYdNeTJ8=;
 b=jl7J49fmWgJrTyaMZQEaGRRL7sNQW27gz8PRA5BkzenJsG+UtuaXcK9Dj2tTm2ofr7aigFc9JJt1plbOCmSNTOwkiXWQIMVcXlS+qE1JLwNV2Hd+Liu0vmrKhi34V/c50t3a73UL4YwYOvYy/RfIU3j+Kj51oVlN7IM4LOxKFZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SJ0PR17MB5040.namprd17.prod.outlook.com (2603:10b6:a03:3ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 20 Jan
 2023 04:54:04 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.023; Fri, 20 Jan 2023
 04:54:02 +0000
Date:   Thu, 19 Jan 2023 23:53:53 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: cxl nvdimm Potential probe ordering issues.
Message-ID: <Y8oeYfyqNuSIIxCt@memverge.com>
References: <Y8CNw/fZT5fZJZcK@memverge.com>
 <20230113091213.00002146@Huawei.com>
 <Y8Foj/12QNl0C96o@memverge.com>
 <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
 <Y8hG4OyJL7l9oD2f@memverge.com>
 <Y8hJKcy1993SFLLJ@memverge.com>
 <20230119124244.000015b3@Huawei.com>
 <20230119150449.000037f2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119150449.000037f2@huawei.com>
X-ClientProxiedBy: BYAPR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::25) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SJ0PR17MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da4881f-0a99-45a8-e086-08dafaa259ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4I+O7UFOus9uSN17wTbu1sAxKCs09J4BBRYxL9gheF0bu2YkiD670JqZEmAbwmdBL4uwVsBjkM6nVNILclpNUtxbVW9HPsLOKKjcYDd1OVii/9sxQzwi3hx0uVgIHI/04DdgE/8bcmPqz0CQga0v8GF1cIJg5uHKyQYJ/JPmOXZWxgkN35bGN6Monre/rVhvZk9wSnsfoIJN5pQLuijVxDs7AVzhZWXQGb5f6QE3EkywWgb50aMJX8XtavtuNt0mvLN1aBHdmIqZq8wyZsyfbcrKPEcERWpzEQet9qUL63+SWeGvX0Jm52ngolczwq5zRGBQlO2mWwEbVItULtJT+d1MoDH7gdXvcYCItYBcK2x6nImy8KtGO46dkaUZJSgHPftSqW0lNV+nS3sVU2J33vsNSubY+4NWIE3PUr/DOZ6x5KXgBAo51aYTLk3HW1oZnXjVqL8pKnwt07uybPC1q5Jxs/+tXRGpGmBet5AIzhKMBcpmUWt6RJXnniUVk22vh+BMjGTkI12vehUnB3Khsoa+Z+cfVv+Z/YpYnw6KEqVe1DYOvyldOhsVk5MpCmxfcxtHbwKXCDWcdsv3Espx3rWS/l0cMRWtULLcGSwxDPkML0XJqntCsjhtyPzxdUtvsG/wxZ5HS1cc5qWAWinjL1wuyP7Zl1lJCfAj4ZJtEj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39840400004)(396003)(376002)(136003)(451199015)(966005)(6486002)(86362001)(6506007)(36756003)(6666004)(478600001)(8936002)(5660300002)(316002)(6512007)(8676002)(6916009)(4326008)(66556008)(38100700002)(66476007)(7416002)(41300700001)(186003)(26005)(2616005)(2906002)(44832011)(83380400001)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnpXSWlMWnpWdmROY25OYm5jSkFPb3pWYnpLV0lZWHBEaHlmWGY4WWZhdERx?=
 =?utf-8?B?NXB0NmRmdjVWS1FXMDJGQUd6QUtCQlB6UUdxaFJyUTUrSXc1ZWdZQXloV1FO?=
 =?utf-8?B?K3FiK3k4dU11YUFVY3VRWHZlNXZ4VFFCMnZuUVBTZ0p0a2JtWE5rOTZhTCt5?=
 =?utf-8?B?cVN0Vko2enBkQUVBRndPUDNINitzdnNkdlU1ZjhlL2VRaC9JWjc1Z3FKMHAw?=
 =?utf-8?B?Tk9vK0JVMEVEeURIZnpnSlZYNi92djBPS0xnUHd3ekNqcERlb243QlVvTUpn?=
 =?utf-8?B?V1l4SEd5RnpZeXFaNkZzYlE5MHpIanF4U0prMytKaFZnS08rUjBiOWRiMkdH?=
 =?utf-8?B?Wk5Oc09kK3YyMlAyVXdWNCs3UWJQaFhsejBiN25IaFJ0dWVNd1hSZkRJaWRt?=
 =?utf-8?B?cy9JK3EwNlJ5YmFyTWNxam1XQ2Vsbm1MSGRGUmFmUGNSeUVHazF5Ri9QUHlE?=
 =?utf-8?B?RzJBb2NjbEdRV0xKM1JNZ0hKeDFON0RJQ3I0SjBCWG00eURZWWpqbTNyT2pI?=
 =?utf-8?B?dHRuM0pmUGxDUkdIVnVSNzFMQVlNa1ArYkRqRWFCN0RuTFZFa0FhVjYzeTV5?=
 =?utf-8?B?OVQ0RUdxTHUyVlYwdytrVGtvaDdCcHluNjNTRGcvbDl5USs1MjNWVFAwRThM?=
 =?utf-8?B?UGZDbFhxQ3VmZWhobm1aK3VyRUQvK2krOE90RGRvaUpnUlBSN2ZnVHA0dXZo?=
 =?utf-8?B?eGZUZldqQ2lCNHR4QmRCelFBeEpNRWlCWVBwSnh3ckRmbjcvVUFISEJaaFg3?=
 =?utf-8?B?L3NWVmJkYXlyT2NHRFdhTlRZaE5ZaDRPTWxpVEVuZDk2NzNxZUZkclB1THFr?=
 =?utf-8?B?MXE4d25pWDJUaHRIK0dubENsL25JSngvaXdlVWNvY2ZwekVOWUQ3eWcwYzVw?=
 =?utf-8?B?am1tUEN2c3dnbWpHNlg4dmNnZ2YxNlRDVTJiVGhNSHNGaEg5Q3RFVk16WENP?=
 =?utf-8?B?SVdCRUFxc0U0cU83ZllPVk1rbHBpbGttUXk5dllNNVdvam43NGVUYkRabVBu?=
 =?utf-8?B?eEIyTEtmdzVTcVFZblU5ZnhiNldkbmNKbVpJVERPMjZmek5wdFZpVHAyNFY3?=
 =?utf-8?B?SmZ3TVN2NHJZdjhRQlhBUEtqUCsxSjBXYkxtd1UrUGV3NmdHOUZNbEwySEpZ?=
 =?utf-8?B?UVVtMVQvT3c1Ty92aUFUUW5kVjVWRTBpc28xd1paZmZScHVmNjI4OVY5WWtZ?=
 =?utf-8?B?UFZoRkM3bzlIQlo2VHhwTnk2aEJWdDBlN25INi9XOVRkbUlZaUxiQTF5bzNw?=
 =?utf-8?B?TEppRDRwcGJxY00wbnBzUVhMRGxodTdxL1FjSURpMll5OWlaczRWeWQrblN5?=
 =?utf-8?B?a3pxV0NYeFlHOUZPNVdtb1JJRmJySjc5ZURPNG83Z01hVEdYSVRXWlhZS0Y4?=
 =?utf-8?B?TmxrTWJkNmlkT1dpdEZNamxOQ3k3UmxGRTNJNUxPY2dvRWh3SFBkbzhYem04?=
 =?utf-8?B?VFI2bDYvWW1MakpDd3VNTGsyTThEY2ZJaVBKTWFQSktlT1pjOHRrd25yUk5y?=
 =?utf-8?B?L2NPdWNIL0ZMdytidElLa214QStqem5zL3pIZGlwZnlyaUdUcjkrMVpHcVp6?=
 =?utf-8?B?RzgvL2Q3UldYVUs0WmtFZExGTURtZjRrNkR5VHkyZ2pxVDJkRXhrTDdDZWJN?=
 =?utf-8?B?ejlaRm1FS0pBOGI0S0xPUnR5c2RhKzEvdDJSS21JdU1rM3Bodnk2YytUVzVz?=
 =?utf-8?B?S052cyt3djNGK25ROWpvckpqelM3MWxNaXhWNmZFbGc2WmhlaFg0TzlPbWtV?=
 =?utf-8?B?WFIzc1ZvbzhRa2k0ZGFIbnI1TDZYeWJkUWJjNUU1RWNseExkcjNlQTQzd0ZQ?=
 =?utf-8?B?MnhMOURtTjZnaWZYNjc2SEp0NGk2cnJJeFBJZnlJV0QwaTU4RXY2ZTJUVjJw?=
 =?utf-8?B?aWxPTmtOUjZPdHpISVBJTCtLSUZMMEp3MUU1T3M5SkpoMzRKeG15cFkvOTJm?=
 =?utf-8?B?WmJiNXNmUXdrWE1ZempRZWFmSjBYTXFQQ1gySHA5RDZxS2FobnZNbDRXNmRw?=
 =?utf-8?B?d3J6NEM4azN3eHlFTGpqWEgwMEQzdnhFdy9YeWNUME9kWXd2NmkxNkFCTHFn?=
 =?utf-8?B?cENUdEQvS3U4NExNbHlzUXd0emp3U1dyRW9vMm1vL21GVnRmUTZDaFQvT0J2?=
 =?utf-8?B?NGx1TWJGTklaNmVpSmtGRjRGWDUwSzlEOTBCZmJvRFNRZ2RsUHNCQ2tBUFQr?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da4881f-0a99-45a8-e086-08dafaa259ea
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 04:54:02.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJKWo421o07+5b+8C2/9CFQUVocr/bxCaF9jc4EdwNRP7oKPVrxGOQw5NG3ik75j0bM64o9r0a9wyCVGwmzRrKyrFSHnv7rXFjJ4AIGj84k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5040
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 19, 2023 at 03:04:49PM +0000, Jonathan Cameron wrote:
> Gregory, would you mind checking if
> cxl_nvb is NULL here...
> https://elixir.bootlin.com/linux/v6.2-rc4/source/drivers/cxl/pmem.c#L67
> (printk before it is used should work).
> 
> Might also be worth checking cxl_nvd and cxl_ds
> but my guess is cxl_nvb is our problem (it is when I deliberate change
> the load order).
> 
> Jonathan
> 

This is exactly the issue.  cxl_nvb is null, the rest appear fine.

Also, note, that weirdly the non-volatile bridge shows up when launching
this in volatile mode, but no stack trace appears.

¯\_(ツ)_/¯

After spending way too much time tracing through the current cxl driver
code, i have only really determined that

1) The code is very pmem oriented, and it's unclear to me how the driver
   as-is differentiates a persistent device from a volatile device. That
	 code path still completely escapes me.  The only differentiating code
	 i see is in the memdev probe path that creates mem#/pmem and mem#/ram

2) The code successfully manages probe, enable, and mount a REAL device
   - cxl memdev appears (/sys/bus/cxl/devices/mem0)
	 - a dax device appears (/sys/bus/dax/devices/)
	   This happens at boot, which I assume must be bios related
	 - The memory *does not* auto-online, instead the dax device can be
	   onlined as system-ram *manually* via ndctl and friends

3) The code creates an nvdimm_bridge IFF a CFMW is defined - regardless
   of the type-3 device configuration (pmem-only or vmem-only)

   # CFMW defined
   [root@fedora ~]# ls /sys/bus/cxl/devices/
   decoder0.0  decoder2.0  mem0            port1
   decoder1.0  endpoint2   nvdimm-bridge0  root0

   # CFMW not defined
	 [root@fedora ~]# ls /sys/bus/cxl/devices/
   decoder1.0  decoder2.0  endpoint2  mem0  port1  root0

4) As you can see above, multiple decoders are registered.  I'm not sure
   if that's correct or not, but it does seem odd given there's only one
	 cxl type-3 device.  Odd that decoder0.0 shows up when CFMW is there,
	 but not when it isn't.

	 Note: All these tests have two root ports:
	 -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
   -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
   -device cxl-rp,id=rp1,bus=cxl.0,chassis=0,port=1,slot=1 \


Don't know why I haven't thought of this until now, but is the CFMW code
reporting something odd about what's behind it?  Is it assuming the
devices are pmem?

