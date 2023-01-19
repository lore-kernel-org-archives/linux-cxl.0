Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364B1C004D4
	for <linux-cxl@archiver.kernel.org>; Thu, 19 Jan 2023 14:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjASOVK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 19 Jan 2023 09:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjASOVJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 19 Jan 2023 09:21:09 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4D1BF2
        for <linux-cxl@vger.kernel.org>; Thu, 19 Jan 2023 06:21:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeP5mfrBSZn0lsYZb47asyLktZgORlKXkLu/yymBFqSSuXBGd70Q8pWdY4OzOhekEX0WkMINVHWwTdhGzEme0EdlKfCY2ExzqR046/f2naZDt5DRZcWL+Iz/Jo989J/s4ETF7qS+1d6Xwbc2KhzHPmpTfC3t0upOmJRD9PAvaYFyjpuR1J4osmC3ChpE7uTZeWLaXHzdDlkgVdsT7TWZIJ4tsc130yeVGVCQKPHb0vZkLRP/4pnhoQd7YJWvepNF9aCKQb5QLlPyGNMeooIB/PUEnRmNfImS6LKIXQpYMPDewZgZTDkO9CHqT40q+WWhlFSNivlZ0z6TjDRTu2xuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wPzZI2JTDSlzoJ03tS1DJYf+O5RJElZ+IOUoKEMlJg=;
 b=mr5X68EzM0jSncqYbYLQjO2jJi9vqo7PG/GxF9LsuvyaJBUiISBG0PldrbrSRw2aXLg9IHzuFMJibU/3Pu9fFjCdHbfUiy+sLIKVB1kGFlVj2AbPWywoVfyjliAjQaHOa6dp2SYZvPNnsaUmfFCitOP8TQ5ldnj640A57dWjWcl9k6rc6UXlSwSdzcQwMmHBVxSQJwCyiqrB+9H+hupectN7lMPA1qM/AMkrjDM1HiN8AnGAnMevqB89FvAQ9P97s8RMaJ4k2gj97PPVjb61M10cp2BAcHw08FieilY05n8GrJrIubtMQeDjuxNECtziejRN7k8TQhSDb9o4V+yl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wPzZI2JTDSlzoJ03tS1DJYf+O5RJElZ+IOUoKEMlJg=;
 b=c3eRpEn/fnqwOMi0YlWf3ceyFdNarH7aMcWwmTxjmK7u8DacZz1QtVSm9RmzoTC906+2q3PlHNcMQRWjscMAQOrdSohKJ7RSMFjrpZxNm05ui4nZrA1+xOTBPxqHMNecwppZYmJ90980kyKvYPMmXKiD6ppVcT+B5LrBGXtGQXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH7PR17MB6507.namprd17.prod.outlook.com (2603:10b6:510:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 14:21:05 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 14:21:05 +0000
Date:   Thu, 19 Jan 2023 09:20:59 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lukas Wunner <lukas@wunner.de>, qemu-devel@nongnu.org,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <Y8lRy7vSqgYfRgTL@memverge.com>
References: <Y8AppXP+eP9cEz+i@memverge.com>
 <20230112172130.0000391b@Huawei.com>
 <Y8CNw/fZT5fZJZcK@memverge.com>
 <20230113091213.00002146@Huawei.com>
 <Y8Foj/12QNl0C96o@memverge.com>
 <20230113144026.000001fb@Huawei.com>
 <20230113144511.00001207@Huawei.com>
 <20230113151206.GA20583@wunner.de>
 <Y8hG4OyJL7l9oD2f@memverge.com>
 <20230119101946.000079e5@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119101946.000079e5@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH7PR17MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: edc1a0c3-2877-4795-3290-08dafa28667a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xogRgNuX6oktqEaD27tTOJIWB5vcd8YPx+gYvKE3kRz5SSBeZ+qnbcBA91oRt6gv9cs88o/pvK/fgSyhLQufwkmb4hB2iOUB3MDsu4swirRcuVTkg47Y/bSCqqbDfAe2mgRILD8E442vy1FyOQ+PcP0wkhv0MrKBWU9uT6ZCWL9M5E+Xlz+c/oBHv9ZxRjXP5qocpJE1J/O4IVpYWUyLvsmIHhL7zIOKinBNn3zcDJXw4J4bpUxGgwhLOyWcwCSfwzpHP/Dy7BaKysTVJkhXZSiK/6e0LiCZ4XF4KKduV+P0C+Vkr7wMxl4Ixgzk9x7cHaTcEpppjZnird62D90KLgeAYqeKJYq1gAQojtAnNI/lNtBbnOzJFXzMAO1Hdb2yb7TykvB6STi/flHcgTiGEfa7Y8NWs+lnKRScTSkvDDS6JtyM8LGxT5MisDC0ceQIgmKxTzZzUvrTAo+xHfopc3EqdR90u7XZgwKf2FT3WYr27yBEvzU5SOySZHUY3V+Tuni2fqThreTb/Ihi8aqDorVROxmb0wOA9arh+9LQ1s+lQaMC665jxhrdO4HVODuIWvVPiVabNwwrtaDGXfPjyL3tivJ3woli/OFbMusvxbUinjwqQdlJHmZTgym6pJbbHcAsh2CpRXyJmlTZ6AxLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(396003)(39840400004)(451199015)(36756003)(2616005)(44832011)(66476007)(4326008)(5660300002)(4744005)(66556008)(6512007)(186003)(26005)(478600001)(66946007)(6486002)(8676002)(6506007)(6666004)(8936002)(6916009)(54906003)(316002)(41300700001)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QaGTmG1LjB12TlFhXJR9eMFvVXRQGSVV7Ufq35ohdjCE2K8iWfOtIM0k/J8I?=
 =?us-ascii?Q?ejKm3AqZR31prmpIae/weoiaKAFtJ4fXxRl8+G4rthVOO0GpyMb4UjFkgqe9?=
 =?us-ascii?Q?gzqtpQ/BUY0KYbuBA8di04ueztl9/8H0E9fXT9Lkwicp+RuEO9UN/UVz5hMS?=
 =?us-ascii?Q?ABGOuW2WWUrOfNc3lOrGfL4mh8BWH1EuvnrHe5ujs9KJHvPQTsSYyeAG920+?=
 =?us-ascii?Q?dFu6oFGDJ0dmw+32j/xpURLRZwmAN8Ak1v08CHW+qPC5AEekbrd0E9ZrsgyR?=
 =?us-ascii?Q?0g7L75CFLQnlg8oB7PpvwfhvJvw03rZMli8jXetszBddp5DxufVmpC7ahz4F?=
 =?us-ascii?Q?GFQJRJp38oGb13EGYzjTA9C2lxol7xcHd6gzzIJUQXzAGfAPPoBwGK1Rd1Tw?=
 =?us-ascii?Q?OGvG150NGaAWPGewpDWFj8f8c3k+viAemzo+lYV5HrUYn1LRy+eq7JpJqHxm?=
 =?us-ascii?Q?0pVHchKj0gJkoqUu5ui8rGGqGeqJ5vm0wTsv8Ks2cHhQOZ+5Q+8aPYTPJ0sG?=
 =?us-ascii?Q?9euaTGN38/1aAxDYRpHvfauGcZ3pRo2Al7qxdQte5O9zIJ4N2AXcfPx56eH6?=
 =?us-ascii?Q?tm2ktahOHoBBkltcGOxJogoGilCvi2cd8ZaUTW92qHTorIQnblF1TeK+9unR?=
 =?us-ascii?Q?eXDQ55wXWzAKGHKMfZPLDCVTdQATgXv1L2LTqOaACfUE4mOwnFyVwChpxywJ?=
 =?us-ascii?Q?XFYdJfXiJXAMzTS93FCyPGnuT20Oa27XonVa0fnK+5xhJPrf4935mbOzNiXF?=
 =?us-ascii?Q?Xndbkhk9Ud25LHKBW+uUZLBGPlW70ozHHG57zqxkcuk0oeCE0j79YLjE8qgc?=
 =?us-ascii?Q?5aYlHNr5k0gAd/y5LinjN+D1lkpSiWKD5pjm8asW30DMq6jiMruzNXKYCn3d?=
 =?us-ascii?Q?+fYNHaveGA0fAiTWe80lywyitK7VTneOCmbjHDZ5XKp1oDDZnttrAOVbm9lW?=
 =?us-ascii?Q?defmSusE23OjuTIKd13+uVrngij/W1MkLNrzZ/CluHxhC//0fJXS9ugbODAj?=
 =?us-ascii?Q?OWSbPy92rHOKHISRrZPbiuEQH5kUXGPl0wXwU5EAxGnaQ3mmYLeWIhgPVpXs?=
 =?us-ascii?Q?VVxhqG02WU8KK9H7eWdHN+4SEG5UvNIbCHxaI4S4Mb9wVRbvuVPR+kz5K1Wg?=
 =?us-ascii?Q?XZKhwJRPFWg5/GVEdZl89QRyC5fOq0W1Lpx1U3eXMVvhkdeOyrGAY/+lhhuJ?=
 =?us-ascii?Q?gqkZOMpIYhH0+B92WUia12sR3mQKepiJ4naVIDICiZF/MTIODGQMXPiuvc/C?=
 =?us-ascii?Q?s6X3Lc/u2JY7cdfNEPyqBjFbS7kvA4ggyX5Pbi73KmmgUqPsbZGXII9tS6bR?=
 =?us-ascii?Q?NUnk7Hm8ReLGwwp6qMFFRuAbFg45oY8k47xe4priFSPUXsnTBn0H5wPgHyFv?=
 =?us-ascii?Q?oGTT8+gqJExJtfk4XFnN7OyFGqmmn4OFAYZBDCcQSD93rmJhFxb5CesT4OEJ?=
 =?us-ascii?Q?gZeOowverCNyGJwhynrLW5ZMIOU0pqN3+u0Dm5NNu0BoPHrHmnfBMQ+zKHZt?=
 =?us-ascii?Q?gQt84F3AQrMfU2OY8NqjmX9ekEHlhXvroTrcA6KLtVzlhZjX/4vYi1dqG5tj?=
 =?us-ascii?Q?iwLi2fMOgGSlSn+GhaF6xjWU2n2qiDBiCikNW+h+y9A+KZE+bOtdx78bima/?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc1a0c3-2877-4795-3290-08dafa28667a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 14:21:05.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5jhGA1pIk18SEhqwUjhkrDWIeV3aeOi8tlh+kY3NIrMnes98ntrbcOnl6ILA+LWSyBXtgAi9O81+fCi6nxrqbcl2Zkgiy3wbskVJLAA2G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR17MB6507
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 19, 2023 at 10:19:46AM +0000, Jonathan Cameron wrote:
> Even if everything else worked, it will currently fail because of the
> issue with pass through decoders.
> (Kernel assumes always pass through for single rp, qemu assumes never
>  pass through - both are valid under spec).
> Add a second rp for now.  I should be able to post some patches
> to work around that shortly. 
> 

*facepalm* i knew this and yet i still kept old configs around.

I'll do some more testing today with 2 root ports
