Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC15C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 17:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjAaREL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 12:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAaREK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 12:04:10 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0924916AE4
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 09:04:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYBYcTYGXb3JTRWAHIbilEqm9NsZQf8Ypju9fMIzClAQCYrQKqTHflMIyjKU863ahJR+fOy0/vvYZlnNkdZq8MVVLPHhmNG4WNgAfiQa5275BGzhOH27NoufyjAZc6nmbbVI263YMgLoNtuB6bUIj79XcN8iaA0RYB3V8OJwkS1R/h106yiVHQUS/sAfc8oGffr+zIIE3DBJrWLnyPcMaafKkP8PVck3ncGlfmz7i2vdnNp8mz2XKJrjJtugK/ruHy5Ae5UFApXCrmmaDQIe7vARZO3AJHYhadVUvb0hp2UthGyNbYjShKHdX3MteX748gIqIewMXTih7lfn7Bmjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGJ0zIF6e3SgC7hV323cZ3YeSXRu1fvM29xzppHE1TA=;
 b=EnGWxzScN5TOcBju9FHn8v+jG30508Kuh2HBu+kElPgJUsvgsgW/IEyNtNZj/epMuoYGVltH3PMYYjKRrdnW5zU7W/72FaO6nVNC1UBQ+xzSWoNzsOeBH9XaXFvStIeA7LA2gCaUwgfsNBsF3ZUHs1+CyMiUBADp+zmHYN2oxvqPTlr1LsPM76fn91WwI0rd40sriWjt8DBCKciu6mup4gFcyocWBefJ0xNtNbmx42EZxaCnxBQCy0TF0Rzd4HXgwVMtWq6An/10WnB4SlW/Sa+Qaz6imLV1bLhWHp8/N343JG9eq99k9TCa9+9rTTPZCOxkG/vh9HfeRy9WHBWAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGJ0zIF6e3SgC7hV323cZ3YeSXRu1fvM29xzppHE1TA=;
 b=Pom13VA7oeAWER9DWSK0rDibACUi/QKZncwaOwKFUzcAYaeELSW1IurIScIT8evBCYXvg/HVpExBhO9L7gDrmZ5GB6Wf2VDrrXGb8xT/YZugmFbMRh1CHaqRa/+LtFqKwbdTvCvGdl6h0LIqhemvXJ13PMiyUFfhi5ddPTsBwfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by SA1PR17MB5190.namprd17.prod.outlook.com (2603:10b6:806:1e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 17:04:07 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Tue, 31 Jan 2023
 17:04:07 +0000
Date:   Tue, 31 Jan 2023 11:25:55 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: Re: [PATCH 2/2] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <Y9lBE3dpmFGBeOxF@memverge.com>
References: <20230131163847.23025-1-Jonathan.Cameron@huawei.com>
 <20230131163847.23025-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131163847.23025-3-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: YT4P288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::22) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|SA1PR17MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb10880-26c3-4d20-ba2b-08db03ad2a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bg3r3YhfkeLLhhMdkCix4HgRedYZ5fIvhN8JXfruo1nkuxWjfZw+v6u3U9obYb8cM5tajZO1IzMmorFF8y67U4mV3Ep8ZgeFkOgJOjidO/fDtyl0UpCj5SH66290ZkXHQm9/6IfYLNKyU4f9AO+dcjvBycX4YLi5v6QKifNTgHD7DoSqgOsimQ3PnxfAqXfcrucazduoNdQ9jmGJjvoQ12Grhk+LpG5iG7qP553RuMCu3++kUY3dOt23YS0WpdztQHY7etieA+LjEkGrO1qnjYV71/Uy8KJ2KGTL8qGdBVd3DZewVcWmqVjhHhb6If59Q+EehIzvTR0/2OnqsDSInZAbzO2RXelkKJs2XkONs3DfQtdMpA2w7xDpBRxOXprQhKTnC1WYq0zEU5tmGWDx+8Ysx6r8pdmgd+KBc54HSYJfzTvnjpMbojGPbickjMY2Vc1kmZ+DQ4XjwM58cLltkcHzJPwnl7UQkzNJ7GihHli7C8Y8KItVbUPAVh7VDMVGfCmDoLDemEP9Mnnj1Ux/TxvxiTHUBK3MwtLYZVcO1V05ONwq6McyrenozXlcz0sCfE1/eFnwZBHUPgq0GPM0gY1Z130eB/PLzZpkvBUzVTtvPso1vkIHCsYjIpLlwH6peD0D7n9Jj6ArUbYY1Mt5Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(376002)(39840400004)(136003)(451199018)(6666004)(6512007)(41300700001)(2616005)(6486002)(26005)(6506007)(478600001)(186003)(66476007)(54906003)(316002)(6916009)(8676002)(38100700002)(66946007)(4326008)(66556008)(8936002)(2906002)(36756003)(5660300002)(86362001)(44832011)(7416002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?atrlQZ/H6q+/x/VBG4fNr5aohWwwrFNIUFWomG2HRmRKV050+ASsJ+4j4Ytl?=
 =?us-ascii?Q?4vbpmnNS/B1M+xP1Oit7hLdMLLg3a0jjzAGk93VoL1AxkKtc7DEiDHSmOiX9?=
 =?us-ascii?Q?/rtP3sApZcyI1Vb3iRh7P+u1P1fsDpLY7JtaBwROnlMnJ03EBpX9u5JJalkI?=
 =?us-ascii?Q?5u6kySSPESGuty5PVVqKrSTPNydkQFQEDtE9Bv0MmiQCWqi9cZQ/YCmnhPHZ?=
 =?us-ascii?Q?XUzM7UFV1IIlIXRKc1IsVy/I3oC9F0H1tdfEbrfT2S1uMeSwsSjd7h8wmuS0?=
 =?us-ascii?Q?LayZvui/0FSRx0XZFEq07+VBlQvyhncLAMMQQzpyB0IzFAKNR2ycTGqDJlgs?=
 =?us-ascii?Q?hLc+qqmKqLjRtpoWXjF8cV2qdDPdea7IQZ9JqmnRAqy2I+wR5BePDH7Vprfq?=
 =?us-ascii?Q?xBM3Y6XHyhkN27f7AhkQQ8zRZf+iqznJV9Iv/X/flQQzNls5vq0qa8Q40ZMo?=
 =?us-ascii?Q?Lxti+QWafF+H3Q74FNPUc+an6O06+32VeMzJBnyR5pIfSsPOi2GYPicIF62O?=
 =?us-ascii?Q?GuLzBkPUJGbKcgYzu/Ir8BY/eYLV/arQtBG2HlzF4Xb6qsP9rw+TCerzd61H?=
 =?us-ascii?Q?qqeUp2gOIVmefLfXcK/+zmPgQCvM+Q8BtdXZYtZ8gNIkCZQxk9WMkebj9XYF?=
 =?us-ascii?Q?a7o3UUZAVl5lablcYU7W9ljgwf+1psRVO9+ZJj9QlPq4XFLoQSoQyjjOJu73?=
 =?us-ascii?Q?Y144KwDHS0xVqpBA5DBhjCOuThzh05oSwh6qA5IrBv1TBIwFvxdOEan95Dfy?=
 =?us-ascii?Q?idZKj/OZcaOqRPlQXdY1swJsR0jDsSMnSXNQ0rW7YqwPMQExxOzkQHPTLSzt?=
 =?us-ascii?Q?pXKFVj+FLCfuCvzFibSR4AwDS7w5Hiqg/8WC/tydxjOStUFtUwKWECHjOOxd?=
 =?us-ascii?Q?rlJpWfcefYK2fTvTygVgK6ADamLn320KZac+ayP+gZsa5iAq3LPqhb2qXxMl?=
 =?us-ascii?Q?7ejmR0j4bZK84QEZBq8xLIpQHYP460j4mL7PWiSWzjmuh4vJ2ib8CSSWKiIb?=
 =?us-ascii?Q?XOrcUiZq384agy+UDTy9A4tmUl2NCYiKpHd8uyx2haZlX2DZcBll0sI3kYZ/?=
 =?us-ascii?Q?0DRvpcAHoUOsx7HWnjqI1X0JCy8DeIelPM1+7HS8HMGZR4lczsZjNiMkp0JD?=
 =?us-ascii?Q?o/tWh9iUDmvHWpT2b+DtoMBFaNeICAZv4cKYJJVZIh77mTBqadoMAKvJlR5o?=
 =?us-ascii?Q?iqCHZLbUH+urFXY3eSJilNXbobP5hzZKpVR7bigMRX4rnfMSjQj/LEa3WpW2?=
 =?us-ascii?Q?7xmwAe4mnTxNEu8NmnjCS1e9Z3fe2IGDP5RLIJBkfqFxuClWeMUz+/Kv659/?=
 =?us-ascii?Q?/gsRZCCjw74mZNVA2G+TipPRT+aKJxBR4wpzpEj2t0+1i/ldMd/zwEZohvRK?=
 =?us-ascii?Q?Hqd/afL45X+ShzPWi9lTooDUk29mLN4TLo5vKWunqceqWzDrGzMxL5QbGa3O?=
 =?us-ascii?Q?H/x4oINVHVd6H5GfNGoW9HY86ydUPVMR6thU4d0+msQ0yLGQgAkQ+xUkiAIQ?=
 =?us-ascii?Q?doOS0nidOoX4KAld80gmdy3h2LLw/Vslr5tY3AkUl5gxa4rwTG7UQTxNWoGE?=
 =?us-ascii?Q?xxruPqAaleyDuJAH/4UuviPOU38Fti3XC9m4kOzoAzX/f1m828ig2242qSop?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb10880-26c3-4d20-ba2b-08db03ad2a31
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 17:04:07.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SR/j4m9ppmM/xwwtcFRZFGUCc9Q85a+YY5IWttktGwrutgU4sotbnEDXvfIU0DFk8fZoQ3xxPo+1CBUR26wNuB/scDiIwl2PJFVTKRYGjy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5190
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 31, 2023 at 04:38:47PM +0000, Jonathan Cameron wrote:
> From: Gregory Price <gourry.memverge@gmail.com>
> 
> This commit enables each CXL Type-3 device to contain one volatile
> memory region and one persistent region.
>
> ... snip ...
> 

I have no objections to the changes made.  I'll test when I finish up a
few other tasks.
