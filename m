Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53975E732FD
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Sep 2023 18:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjI1SM1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Sep 2023 14:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1SM0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Sep 2023 14:12:26 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5811F
        for <linux-cxl@vger.kernel.org>; Thu, 28 Sep 2023 11:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdeILbEXxSEQpPAL6vQk4cuRQv2y+1842Yjm4GIRwwkLkOIEKaBUTdcjPMPURNmIQQ30yfufQZY7P/jVVYfKqX8BSXvQfYRaxIH4+z2nhydT0iWXot2/A1WeLH4vKlum4N58/PXCkaqT+HUcQMtlOhPbN7Vs0mPhc8WKW1DKzZEOWtkZoNkOTXSBgtcVe8lAhjHT63BQeK3yUgUWcmOhdSA9458UoZ1/yWWzQctihIagqsgjVddQ8qTLnt7rJ3ola6HEF+1Wy0S29RQSA08ZtCpI72zm1VI0HOlLTR05wCJ46hFR6wKsTy6w2HWGC1tbSuSg80XCpNkFoNbBEOkSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HuVN19hIgq+VhbXsgSmxBOlyfmUpipRtMS+zRwTi0k=;
 b=FNv8fGoolQEctz4UAXn+ZlADJ8wDwJlbKMgHtktzNLhgoOVA6IJsCm+/O3bObwsYeEvnDeWt6jfWsulHqEuKu0JnQn1OA9+8dWFcSanxcRawBPYWLHWQtPN5aJEIxoexe3LjawnL1nnMzVXU/H96Uj+v/naFaWI4B3xgyVBCpHyRQFusf7C8AbRN7sqJlCGroNzlKM9zwoT2y1pwNTYqLG+PIV4bjkZraogFiTIGbVvL9M2vBMJ6Blp6iGVO1stWmhY0EiAedAxkSsD/xP+kTlg/zT149fJ9epzx7JytiEyItcpc1hE7vCiAayQt7afy0J2BKeG2VCaecnRTUiSyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HuVN19hIgq+VhbXsgSmxBOlyfmUpipRtMS+zRwTi0k=;
 b=Yp8ZiiwqxXaEVBpOX2gEVWnwhpwLKnLPi/Cqoj2fhw+ibdfjjU9ovkSwADXK2JSoCOEDk32kq2rFxNiBiyoVgZ6Ue2m6tANpNIAjNmWHMNv6wXki+0/lyfOB+JB7ncYtjDpu2NBq8o/50s6p+7WkFQKrXc7vnLJY6a9RnBU/uWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6951.namprd17.prod.outlook.com (2603:10b6:208:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Thu, 28 Sep
 2023 18:12:21 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5565:d559:61b0:e2df%6]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 18:12:21 +0000
Date:   Thu, 28 Sep 2023 14:12:14 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Michael Tsirkin <mst@redhat.com>, linuxarm@huawei.com,
        Fan Ni <fan.ni@samsung.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Klaus Jensen <its@irrelevant.dk>,
        Corey Minyard <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 00/19] QEMU: CXL mailbox rework and features
Message-ID: <ZRXB/lCASRX5/w0j@memverge.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:a03:114::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d12f5d6-994c-40b2-9ad9-08dbc04e7574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXfKsCn2izlX7FFJWUQ++4dGPq5UOCwkKg/IUonGxLg0rvjYPmA1K5jegK6Kiz6O2aAMKRCrBaLPPUDnL6w17E+s3LR1CBlvFeNE2iAM+PEx/qJmtXL1Qii8Qb1Hqz0w4cdIKzOG8Pw3ckLfAJmJHL8MWJjNohOiOHybdGqpHPRyC6gV8UVuDOoavfJ3i94t905KogufvOvFZpwq/sP7WKXPqMhWKYTz25Uho1ysrbTEgb+/xIDQyQPKfSe4hdlPQizDaT5jlrxsYgkn3YUDnPLSu2MO2sxsxPBjR4kWrGxWU5eLbA63BzLknKwiZmLiL567ybCtvP3uEXuorlCEMcjoZAZPbQmcCCeqNAPoDQ2uTXnW8mDW/BH5kZB6IdU9Qa8GEWpX/iz+OxFauI5QN3VwyzLMC1drvQLg+Fnw4Z4LQgIIb5JCRLynxEGqFgqLQ3p+qskIzmXXb4ZQM3yD4FQWXlrzvzBqCNWv8YDo2A7nP/C8k2Dr8ohems6NTMLRI1eNgeC+o01q9eXCB3KoLCar7wHTp9K22Qcr55kTFKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(136003)(346002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(86362001)(6512007)(4326008)(6486002)(2616005)(6506007)(36756003)(38100700002)(8676002)(83380400001)(41300700001)(6916009)(316002)(8936002)(66476007)(66946007)(66556008)(5660300002)(478600001)(2906002)(7416002)(15650500001)(44832011)(6666004)(54906003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oyrn8BdcLCtrQNMe8Re+i5s56XANFq8ThDfrCboYivLiKDsf0QTPdxY3ijzp?=
 =?us-ascii?Q?JK1RutgK0RiNqXZBNz6qUFHSEQ8zIO08EEDbESVMylKhoOLj1qGXAg5734P8?=
 =?us-ascii?Q?z2XqEf3qHDDc/TJL/+2yCLooERU6n78XP/kIbry0XaNAKBR/95WgCXR5Rvh4?=
 =?us-ascii?Q?qNZnNg+5b7nWFkZP3dS5AzSsfDMhqfEe/wVunPAdptxBuFa83lQGU/gNhPv1?=
 =?us-ascii?Q?fq0UeAYLua4JUT1UubsiNE4Oibvp0+pBMkoDc6QQV8huvK16ioM2RRdXeBJc?=
 =?us-ascii?Q?loybwiRpBIK8X4BW+H0n8GBcnLKduYhh35D8oZvrgT7cuIA8YAqPJlW9aneq?=
 =?us-ascii?Q?fSy7fUz3eaPUz2tURNLgl9E9o+vuxiZyLCyfK04SMSF8LH1+xv0rwk8pTlCm?=
 =?us-ascii?Q?MVvvceYMzGMEqcBAhEklzxTDYtu+R9EBZrBJ3AhsdA0zqGz/Ly4FmplCZVXl?=
 =?us-ascii?Q?JT6bIEg2CYdUpR8RdPJgGtRTHstDKMIcoPcLoGM7XG8tUSkb4EcYAW+sA3yt?=
 =?us-ascii?Q?PDKE2+cZsSwe0aHd9Av9mhAXB0Z1kkjbhGZs9/8elHFcVwbd4PACXDmwtfWw?=
 =?us-ascii?Q?GyFv3WfRu8W6S53bpEtwhyq5iMQ95X0WZUmYP9R77oEzRtpgis0zenEzUiqg?=
 =?us-ascii?Q?1o2fuyEhZ8gBrYJww0vNa/vfcjW2c1PFgjnxVPYiYuFaACCsoQc4LDghneml?=
 =?us-ascii?Q?6TIzuwDBh7FFP1k6ZWseC3zHafosSTwnbzZO6BLUUKcjXy+hcmPbDttEOpqu?=
 =?us-ascii?Q?z7s1nnPZlipObUdsU/DRYmTc9RhB7XQo+Ty8gS4rMp/iaOwZ+nY0tIHnW83k?=
 =?us-ascii?Q?mbLysWzbSIBCgfO2cXSebHAeH6WXVFch2YARXF3oKoPr/XO9efPPxQnC/Tzw?=
 =?us-ascii?Q?ASkCdH88yQA1Rz7kLzrdCBisV5vh5f6Ko4DD4pGYcu1bzvp1RZ6XMEMRxOFk?=
 =?us-ascii?Q?u1mjsqKQ0N2C9roejwHoCkaVC1gaRSs4lXHf0Q9wZwbhwcIMUzT0khn0AE1g?=
 =?us-ascii?Q?X5vkTEQOv2a7aZvrhg4plxnLMvA+tbhL0aQuIJdFs3kfakYXcNEAhm23CoPQ?=
 =?us-ascii?Q?IkXwnUytQXtI9CUTMox38fJaxfH2sN2KH+o6q7kMuGY581ORIAGt5IRWqHHU?=
 =?us-ascii?Q?kd0SAzlbiuPVuEr1QzC3vTIM/81EotgKVSU1loNrGOe7LgC4VxOBRrsijZd4?=
 =?us-ascii?Q?jqT6hoTvGihYHv/ezs9e8Nu7DETy38kCdJxNhwDv0FIwabSvzNwF6+UHFqNB?=
 =?us-ascii?Q?gSSdYQDXx8vBVUHKJGISF0CH7KR0+Vl+hTM7kexGX+WEJe4neuNRcxrZOIsD?=
 =?us-ascii?Q?Y1UsY/e2BB+r+g/rHON73xlGIHBb8cDtIPmYeLHUNtXTTtqdpG4DqH+rrfn4?=
 =?us-ascii?Q?/AGolGL2mMGuLVk1V663gA4U240QVjknvbKvsDPywrjAqf7OHq9mFIRxaKDd?=
 =?us-ascii?Q?OublkSUx4kdTEV2s4yks5f5TtQkNRplFsbH/H+iQBPIxCJ6CpZ0Pc6/w08gB?=
 =?us-ascii?Q?XAbpFNlkpbBjhgadr6IEHpmjxrkvfQgPDjh5A0uhE6pNFVlBT6YeACAbsiWq?=
 =?us-ascii?Q?jdOq6bwjJlG0EXHpsfoqnaIWT+p+1onsXMDTnwi+d5o26uiFTIKna/ucbnhy?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d12f5d6-994c-40b2-9ad9-08dbc04e7574
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 18:12:21.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw2TIb6l6tD4451W+GeBHFAHX9l7fHegBfbyjpBpYpAYjcXgi7LqSHoj4ic59Y2WvI7EYNe75yCrt8FrxWbZwGuHuMY2W3sOc01gQ1GIgV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6951
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 25, 2023 at 05:11:05PM +0100, Jonathan Cameron wrote:
> I've been carrying most of this series on our CXL staging tree
> https://gitlab.com/jic23/qemu for some time and a lot of more recent
> work around Multi Head Devices and Dynamic Capacity that we need for
> Linux kernel enabling are backed up behind it. Hence I reorganized my
> queue to try and land this before other less 'central' features such
> as CXL PMUs and arm/virt support.
... 
> 
> Jonathan Cameron (15):
>   hw/cxl/mbox: Pull the payload out of struct cxl_cmd and make instances
>     constant
>   hw/cxl/mbox: Split mailbox command payload into separate input and
>     output
>   hw/cxl/mbox: Pull the CCI definition out of the CXLDeviceState
>   hw/cxl/mbox: Generalize the CCI command processing
>   hw/pci-bridge/cxl_upstream: Move defintion of device to header.

To save some list spam, I can't say i've reviewed and tested the entire
set, but this patch series to help model the Niagara work so please add
my tags as appropriate to the above.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Tested-by: Gregory Price <gregory.price@memverge.com>

~Gregory
