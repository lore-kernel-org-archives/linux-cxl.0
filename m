Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACECC636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 19:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjAaTDQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 14:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjAaTDO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 14:03:14 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF33CC26
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 11:03:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fczu2CBZJ2F+/qyJNG3auznTIK3MVujbQEiRcWil4Y252b8/TKc08eur/ALYgoH5+DlC+aZdn5ShJEumGg3h3vmWEkkAiOcS6ZqmLtXF3llagxztsc/aJKpFz2GQryUpkqbFutqAzNeDAcq8I69EP04WdOhu4KbpHopIbogcSJrUjGQ+hIEYOZd8+cSTpleZ5dCTX7+X8hLMX/7j+/jzKym1/hPoVJPP22146aUGeAgIRgeaRSK6q9od22To/seUPG29z3gnTEqYjsHLM7u0bi8+WTMZBhMRQwShxbrS71QpljZRncdID2sza2D8LprJviwnbMfFfWcsEfuw0DNJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir5+vXkFXx3SK63mqpjActax9U0+1IHjxibKz9MSGh8=;
 b=OQkzZmgFhhijgAu7Gui/JOlxvCDJQnaficT68Cwnv007TtLVnPXoeA8tQcLIWumcC7Qiex4qAEZUE5AEa6sV1VFvUjFcyvURfJ68WxaBWow0iGeDr/6jewwo9ODQ6k/GJbeUGh/ZmOobUY54vhL8w8qvoW73hjc5UsQ8ZvtkKSY3xeCnfNCXEuEwW414SFkYaN51f4neqocRYpFw+78yV8zbqjTCKs6RGAT1Q1dzFxSNRq+Jlw/7dSiGNhn6QA673iqP2N2Ss9gXKJK+8CN0UNHmB6ZVqgL6yObUCkTn3f5M/2YqqUv+1NKa+ae/PXPSoojGSz1C6x1oALWR8qpPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir5+vXkFXx3SK63mqpjActax9U0+1IHjxibKz9MSGh8=;
 b=Zgumi28w9wHKXNZW0taSjCRUCD2n+XqmjWpRnCtbUiTmK2NNXA/sPO5B7bRTzgNMQY1nPWXp8loq8E9KI3VoHimh4HpgL94PEj3RiwjvAmsvGJgOK9EUfSvOGTliWuDS9HbX7KNWkGxAITgpJHSyaos39TGXFWIPPKuCeKp+IsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB5471.namprd17.prod.outlook.com (2603:10b6:510:b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 19:03:06 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Tue, 31 Jan 2023
 19:03:06 +0000
Date:   Tue, 31 Jan 2023 14:03:01 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9ll5S3Y4BZkakNn@memverge.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
 <20230126185025.000016a0@huawei.com>
 <20230126193424.00005034@huawei.com>
 <Y9fRVu+yLza4d5Vt@memverge.com>
 <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9gva49IPFOXYlkH@memverge.com>
 <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9h2VhGuraZfEJfD@memverge.com>
 <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51d8e1a83fa70c2caf2835381eadea5f96d27892.camel@intel.com>
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::14) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB5471:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c2a70f-41b0-4522-87f7-08db03bdc924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvCd9qXZcPJDK19bQAmgPqLerN2n1030SrT9I9qpGZa9WmK3OVT4GI72j4PTayhmyZiMPKYhyMXsUCB9YkGQuCT6XIn/yv/OpSG5ucC7q5p/X/w/gLtHzeSDotZGGCNtILRJyTBkyAhLbsJ7vqaI1l5D6iIL9yY1tbx1Jput0go6okRBL0P7RJcn+9fpsgFHAd7HCc2ccXO2QRetNP3DMmTuBwKouoXwzHX/KXZKJEJVNESaXb9v1T/nmzNmshDIHgZ8mGwNdIUS6HRyAwS+p7oy08xESGArefVWvBxS0/WxaPz96/t2lExhK3fch5AtyVqjqOg4abHldbj/gVketVjnGeoHDccUzOwk/NsQRjFzLoCSs8E4nhFm491F3MVoYQoEf1MIA/XM+6kFKP2QHrWfUZRfazdGNQN9YPl38/UaOdZrDLwZDZpeMs7eX1EIF9TB7EvcIPvL20jVFO23pidsb3eycrUlx/ZuLljit3WQtCpTzjIawisYRQawu4LqWmB8ifI8zx0rRuBynS5eQQv9dbEWLjgd356VUgzlzyn7DlFUxttoRCV7fb4CFhX3JFOQMTbYgKezm+ploncHjrLFPArJq5pbKP5qoTGbBckZutLxT1bDZtjkIzDBbtkYM6KxGLj5AHw6g0XMS7gfFIMPq2fVOqVqJYM3ikCwffo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39840400004)(366004)(346002)(136003)(376002)(396003)(451199018)(86362001)(36756003)(38100700002)(6666004)(83380400001)(6506007)(6512007)(26005)(2616005)(186003)(44832011)(2906002)(316002)(66476007)(8676002)(54906003)(6486002)(478600001)(966005)(66556008)(6916009)(4326008)(66946007)(5660300002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Os4MLC56WLmdtG8gnhFh0NE7nxklbdcNWNDqQttnoDRnokHYTvHye4p/9g?=
 =?iso-8859-1?Q?RY8cuUf+nwMHFOg/b1Cd0KqpfyVH9JAbjzPJ+rV+UO88AOTsnwW18f1V52?=
 =?iso-8859-1?Q?pY0OqBgUd5K8iI+EUK73ttATtPQrzkJIZyCzbu1ECsyNMf5iFDtLLdtkvR?=
 =?iso-8859-1?Q?jv0Byxe1ZK9CVjgv6n9Lha+hR9LMl8uZ/MBqFzogdtvMIQQAqF7vB2Z2QO?=
 =?iso-8859-1?Q?tSw+NxJPRCfKy/4SPOG1uCoswpdXfoSmb8JDZ739kMRPpAd5RqrysuqvHA?=
 =?iso-8859-1?Q?L+UNYUf51SI0I5IPbwDuaJuywCA+cbBT8ijcpq8Ws0j6TWJTuaY4vl7oap?=
 =?iso-8859-1?Q?HVkgUDUBJI2w0oKz0H+b44pD4EHSDdGnGZWtaoZ6sDbDZ9Oxiwq7BSNzo9?=
 =?iso-8859-1?Q?T2S0z17Vdp5932Pw/dvk644oxjeMa3LevvG1pP+Wn1u5yxJdh8XDRoOPmG?=
 =?iso-8859-1?Q?Hk28TWDJOufzdffAvacgG5Fss92lic5nQ+eP6085N+odB6ScVOt1I3rZli?=
 =?iso-8859-1?Q?qg7jzDf0DU/N4BOCiGGBI/0EZSQPzAnBTJBhhx3a3pUBhZsUelF2ebjN+J?=
 =?iso-8859-1?Q?ebxAW1k9JGDTXrAlBSq+XrGf+wWr/jcdSEOs5+zHhZqrV6CTFaLMYn2blj?=
 =?iso-8859-1?Q?s1xnVMJSChBX+fO8ccjMZhHsXBIf/njJk283aE+rcY4MrlPZAlE3b3oQzT?=
 =?iso-8859-1?Q?phHhBGCzAIYvbXhSB6QVXwGfeo4TH6PJenLSq5xRWT1TIjGo+XzN8fFdYE?=
 =?iso-8859-1?Q?FoSENx1OIBvVo+uTjeKg9WEKJVGVTMZ84S7eYVIq9ImCf79oiNrG0Y63o9?=
 =?iso-8859-1?Q?i3JJPaiHJ3aOr6TQBIMIhIFS5EZ0G7SzAI9Xp4bUXW/lP3PjtwgzkV/r6+?=
 =?iso-8859-1?Q?5h1QeoM/DR2fU3exFrenu2WvUAHM1gev3dVV12LH/wZxxVOGEf49QCSi1r?=
 =?iso-8859-1?Q?/nb0dTwx4yEMm0mKSfuBIAQ/X5pioZlppbCESmLDRCRDZFopdcIqJxb7hI?=
 =?iso-8859-1?Q?yFg1bZE+jT9M4CZuI80eLUZLSaFWIYbOoKmVsu8RrwTnisTlXqig7IMCL2?=
 =?iso-8859-1?Q?vSORhjRXlJYWg+Ymp3xbmpMvw0oCdQ4Uro0VnYJYwP+LlUJX4i2haz46w8?=
 =?iso-8859-1?Q?/jckXrVCfI5iMufUcnS0ClroqXaT1kdNYALGx5fNjbd5lhxMOAB8nLyHXF?=
 =?iso-8859-1?Q?nFXaNaEPaXatLSx5LdJe5mJYkqBYM2VkEVE4/uGpZLe7vA153QyO3K73Nc?=
 =?iso-8859-1?Q?iG5ACuC5lbpSf+DpXfvlO3Szan/JZz2l2Wq78q3FBjaLKE4CbNv3yq9AHn?=
 =?iso-8859-1?Q?7AkL5qAY3zRw2WcEbVfjzbLPaXOorNJpSlajrjRZRSS9S5piLeGxNklr9r?=
 =?iso-8859-1?Q?bVcDICQ3uOhAOzFf5PtwMHrFLXgs32mP1j+tS6w2yzxtf1pfQe8KLWr6az?=
 =?iso-8859-1?Q?FTlklXuDpdo0oGVKMWtrDNCTb6r7gbKjR23KmE/WXrC86hYtWBf1/C3/zH?=
 =?iso-8859-1?Q?1kCUTP2CrvauADidE8o5tZCwyD86No/8nwhJ17USeGtVXHYg0JlEvwmYKe?=
 =?iso-8859-1?Q?Tcw83k6fXzhvm7qzW4SHdb049fotZapughXVfmUSPWu/htlychkPcvBgxq?=
 =?iso-8859-1?Q?2RmOOvFK7Cu/3gy0KpI4y7urxi9hkw1uLWw7tzz/yHQDEXEO9Lz35KGUCw?=
 =?iso-8859-1?Q?Z5UjRRA8BGTdpJX9j1g=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c2a70f-41b0-4522-87f7-08db03bdc924
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 19:03:06.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAf2GS+jKhVTGJMcC9biXHMslM/vwL81g8p3W9dn+hbLxjzZEcXv/xtYqZoFeKe75gK5TWkgwGX3h6V6OsFHU8KdTm+ZHwFxhv2ikJfGA4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5471
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 31, 2023 at 05:59:26PM +0000, Verma, Vishal L wrote:
> On Mon, 2023-01-30 at 21:00 -0500, Gregory Price wrote:
> > On Mon, Jan 30, 2023 at 03:18:38PM -0800, Dan Williams wrote:
> > 
> > 
> > This worked for me, though it took me a bit to figure out how to wire
> > everythign up - still not sure this is entirely correct but this is the
> > string of commands that were required to successfully attach an endpoint
> > decoder to the root decoder.
> > 
> > Note: The root decoder has interleave_(granularity=256, ways=1), and the
> > region code appears to require the same granularity?  Does that mean
> > we're stuck to 256b granularity? (unless i misread the code, which i'm
> > about 75% sure i am).
> > 
> > 
> > Command string:
> > 
> > # Program the endpoint decoder for ram of size 1GB
> > echo ram > /sys/bus/cxl/devices/decoder2.0/mode
> > echo 0x40000000 > /sys/bus/cxl/devices/decoder2.0/dpa_size
> > 
> > # Create a region in the root decoder
> > echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
> > 
> > # Configure that region with the same interleave granularity
> > # and ways as the root and endpoint decoders
> > echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
> > echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
> > echo 0x40000000 > /sys/bus/cxl/devices/region0/size
> > 
> > # Link the endpoint decoder as a target in the region
> > echo decoder2.0 > /sys/bus/cxl/devices/region0/target0
> > 
> > # Commit the changes
> > echo 1 > /sys/bus/cxl/devices/region0/commit
> 
> I've pushed a cxl-cli branch[1] that incorporates this flow, and allows
> for: cxl create-region -t ram <other options>
> 
> Feel free to give it a spin!
> 
> [1]: https://github.com/pmem/ndctl/commits/vv/volatile-regions

Right now I believe this is failing due to the interleave and size not
having default values

./cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
cxl region: create_region: create_region: unable to determine region size
cxl region: cmd_create_region: created 0 regions


appears to be due to this code
static int create_region(struct cxl_ctx *ctx, int *count,
             struct parsed_params *p)
{
// ... snip ...
    rc = create_region_validate_config(ctx, p);
    if (rc)
        return rc;

    if (p->size) {
        size = p->size;
        default_size = false;
    } else if (p->ep_min_size) {
        size = p->ep_min_size * p->ways;
**    } else {
**        log_err(&rl, "%s: unable to determine region size\n", __func__);
**        return -ENXIO;
**    }

So both size and ep_min_size are 0 here

echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
cat /sys/bus/cxl/devices/region0/interleave_ways
0
cat /sys/bus/cxl/devices/region0/interleave_granularity
0
cat /sys/bus/cxl/devices/region0/size
0
