Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399FBC4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 23:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiKNXBR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 18:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbiKNXBL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 18:01:11 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A77F1ADBA
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 15:01:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv7nVrbeQTapWrGjW7DVmqG65nw43Gmsl5637dkJ9OxJjxcGsy/QiOoPOJMbEXFf/w0aVVt22hbjDurM89ci3WVpDziOSIcW2E6WgLwSwAw9tJfn4N/atIuREqEyDDrTXp8YkDoEmtwq2cJ2qeNs7Z4ayfXWQHZBG8drrhe4NKR9H70N4XaotNTx1zwS0dfehBEmqclwbvbcb16Q7XSwXGjxvI6nO7erEJh1ilXSPy+4BB3FTQkbmkQd7Bk5T7dMVX+DK6SXWft7oh/945/EvAX53JgTYCviNgrwIEnLK6Xk5KWOarIWc4tqCDbVIB0LfV7Lg69+iNOuMH8WFpMDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBrbfYR9D367VR8WXIu+6CKqxOZ8/RLvKkj82zhTfpo=;
 b=gnIjtNfRWnLjgvn8XiYnV2/e7BWiXZVaateZBO//Qg0azPkxLl5i4n8uCO7UEgGil/ORgwSotUMbiZ+vVuTgTJ1b+wwmg5MQeDOYMPe7Znf3hHqHHLJpMOc2iBuA7dG3lkt7RxdB5d5rH/0yFj3aNodraAV3S6K97fKMgkdEcIU76MJRv7byFvQAHxad60+5/c5wddzDRqwej5hSy1EbA//Tfm0D39ZWAyu0tZqWhrlzUrrm6JI2+pqTvwV+aAqHlUH5KcNF6GVaU1W5Qa0E+KRzfpNXe2PD4q13bpCbTNb/yH0W6ejkJPgSPL4aPkaL2QGieBJLw9dCOGLUW8FJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBrbfYR9D367VR8WXIu+6CKqxOZ8/RLvKkj82zhTfpo=;
 b=lO/DunAMQBcqoYyNMI6TEfJSydkzMjWPcqFmQrZTJamAfSYt6+Jk1i9mBuAYJWukbUFcBqDmcRubn8L5p+hGrorW9NPyjfwwI8MlZugLJ00Fl54BmbYIHh9grFaKXskZ8WXVYNUz1heEYhpyPy9C27UbIf9B6jTDGFYsII2bWPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB4986.namprd17.prod.outlook.com (2603:10b6:510:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 23:01:06 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::3299:1f35:894f:69df]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::3299:1f35:894f:69df%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 23:01:05 +0000
Date:   Mon, 14 Nov 2022 18:00:59 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, mst@redhat.com,
        marcel.apfelbaum@gmail.com, imammedo@redhat.com, ani@anisinha.ca,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: Re: [PATCH 3/4] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <Y3LIq0CvRMI5i4U3@memverge.com>
References: <20221026004737.3646-1-gregory.price@memverge.com>
 <20221026004737.3646-4-gregory.price@memverge.com>
 <20221114175341.000036c4@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114175341.000036c4@Huawei.com>
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: b786ecc8-b1f6-4559-963a-08dac6941c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2c5VysbIO5iNfQSU2nqrdJQXx4zAOa6aXXtjo/4fkrRZhULPzSsgLkdSAktu46gNnw9aW2g0VjNhN1pmUmqzgry1YYA6fmOfVyUj+kIQ1GSafYKNsgqJk7aE9DehUA+tlfIZFO4NJGlsOLzJfIE7Eg9EHpr1kjwBGFPa+Z3zc7+qV4RZtPpcmxfm4aBZK6X/iwEcN4yaOooonn31D405z+gDA4m1DbMpEa5AVZCCc7Nq0AZZq3suOtZY3IPC3cyo8EPt13iYLg0WJqVJl9bWpR+GkiazvwmR0TM+BLTnzpBU9/WbJ4cTVi0KV0ZrkgkuwDEJeCFURLWyd8EM92XiWKAs5+dqX6OVyi14XfMIRbBG5SmhKYAxTqL45lgWj4NiIUkIA/bLd/udm/KtuLIzRmvjNpVM3cNaSxWkI6K2v0hkRkwM4btpiFYngddcbHOnoV46Uc5hKHcQeY00OqCpxRbu3NBlVNBxH2L7IUL62jdI7GF13kJi4FMevvX+QHloyt6F2Ka//TtwUfzRTbYPXAJqdbfjIWoQp5p8+/u9cElXqDxDpQUeZcyD30/nU5VZ/f2PBCbgjwEFuiga/ThDfB4Dou2ZqxxpAL4IZtnn76RDzSimoIQKB3ESRJb1CkWPqPk6R4QYupnZ/7jX2V7MokajZZDzXajOAnhiHRJXKRzxkYDQCe8grlKmzH+IFh6mPFaSTPRf708dsC35++ZKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39840400004)(366004)(136003)(396003)(451199015)(7416002)(5660300002)(36756003)(44832011)(8936002)(2906002)(4744005)(41300700001)(316002)(6916009)(6486002)(478600001)(6666004)(8676002)(6506007)(26005)(66946007)(4326008)(6512007)(66476007)(66556008)(186003)(83380400001)(86362001)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFEnsEWPwJGamwuxEGDegoynqeRvasa73EKhWrQxrE3Rms/oL4Q0Z7lhUGmz?=
 =?us-ascii?Q?XS2TWS+4R0vkuc92d0G/ubLily+ppkunI/2FH4nz0ekaShqQXFA+nAk0Avak?=
 =?us-ascii?Q?yy8O1inXIlxPiLSFij/HPrxPkJ0Qt0Qc5OR0IzL/S83Op4N/eWfNILkyAioQ?=
 =?us-ascii?Q?tH4JYV6iCWgKAoyLa8dmejHmW8HDfg8mRbmyfGeZUuHQBLo+hCxPr5Dhkv9N?=
 =?us-ascii?Q?5L9sfSy72UHkTGOsnlqjj8nw3014ptuXWxRxy5vHqkZIZ6MQcbyndCFi7X6P?=
 =?us-ascii?Q?HGdf4s+dmrJyGMEGzrm9nE9upPpO6YonpXDhWzWSUMZCNU5PSB0j+H8aqSDq?=
 =?us-ascii?Q?cyKJDMzOWT87zx2zkch7UjSL9qDLi1RZVrzrDaSOm/VJe/X1s0nv8gAk4Nte?=
 =?us-ascii?Q?yfNLnmz5koD8e1U6FHfAmGTQkKn/VTRAJC7UZApy0jdKTJgoeLqSgmR+hJvW?=
 =?us-ascii?Q?/Q2SHiCXoHIz0nBVvl063wLd307AaNVGeeJ7OHD19e5VYtzsGXRCv3RYswE2?=
 =?us-ascii?Q?DRxVaqDCxwhvqCJHxZ8svtCn5MicBzogZpwJXJHepRz2QhIN8XhYqlEa4wx3?=
 =?us-ascii?Q?pZDYcbvVr1+IK/8OEGH/pfcI/WC5S76LeMcmfnJ7pl4525K/iH8t28zgTEsv?=
 =?us-ascii?Q?0+Swbv7RNp7yaYqZhROQ4AH5OewU79i1Pjkx5grV8tC8lshc+emyKE0CQkPb?=
 =?us-ascii?Q?hsd5PjqANP0LVplKGXShm2uXbEbrKntKDuModotEyv2qIY+v//yUsZt8lhIW?=
 =?us-ascii?Q?Wrp2mccJ86hmiRV/e761oBjblYk+6H5Cd9q0C3W6uGn7IFCwYnY+EUPIHaH9?=
 =?us-ascii?Q?iXtEDxrXZy2+HStg5qYHsJCFQ7BwAndmkk0B7fInNWSHvLPlMC/RkU214sA8?=
 =?us-ascii?Q?RliqM4GjbAGgSKssiRnwO6U9MFKFVkQ8Hi9cH6qxEFRgT0y+YaD0DfIoQLC/?=
 =?us-ascii?Q?x1oPY65ljySr66IDe6NRlc8Amx++e/pjATSRueQPqRHBNRBK3CRkYvomiDTN?=
 =?us-ascii?Q?ISLPMmNB/d2Nre1lZ4Iq0DhQjQdol2SvQiAlQyvdMLTK5n14N94Aj5pHNmWH?=
 =?us-ascii?Q?q+3egVSx+Liglu94UUEFllGsXrPo30XDKsxBeGTQeCdTo2GrWBV8CQZJh/Bk?=
 =?us-ascii?Q?l5Y1CrL6aSIK0tDUEEHBxItPMMHIi86H6dvAYz22wwSHFclc0AVCsXOpgh+g?=
 =?us-ascii?Q?FLrfKP+R8Y7iIgijvdXGsQ18etnuHTI3aA2VRjsd7wrXP3egfP6D8orJDRxU?=
 =?us-ascii?Q?E2xld7O1pe/s40C/gjyOwbC6EKKbQ8UkmWk5wqM3ZntWBdgjZ1eKRWmzxOfh?=
 =?us-ascii?Q?chuoXkxtBSozAMEKdE0pgcZcIfRyqChfK358olZm6zVEfkTYGvlQCnegNl0Y?=
 =?us-ascii?Q?glPeeddJFU6fNedyNOvfwj8kLBMvLaOdJioGADtHHpSIKlyUvWLpKpwrq8qE?=
 =?us-ascii?Q?7H4SLsshO1KOxl2X3hwCQyWNRfDkJuVlVK0qNVGPwVo+ZNo6fJGEcJTCFamY?=
 =?us-ascii?Q?aMv0aWttXwR7qnSDXFBgqygASxUKn0fOgxZ1aBDy3BvQ3lSHzpF+gbMH21RW?=
 =?us-ascii?Q?y21MUDRSvXIFDYdjXloIGBe0V9ByyHekMy+SuUD0VcCmv0Rbe52U//6x94B2?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b786ecc8-b1f6-4559-963a-08dac6941c45
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 23:01:05.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxlnzKIiQqY4Yin6Ty/+R2/EsBMYno40RyKAAhbnxrHzhpXnwEMsx0WBc1lb5X0HcrNI+GffmmFOvr6klJ0PSjW38VbEw5CKebcGxe9Y1OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4986
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 14, 2022 at 05:53:41PM +0000, Jonathan Cameron wrote:
> Hi Gregory,
> 
> I've not been rushing on this purely because we are after the feature
> freeze for this QEMU cycle so no great rush to line up new features
> (and there was some fun with the pull request the previous set of QEMU
> CXL features were in - unrelated to those patches).
> 
> A few comments inline.
> 
> Once I've chased down a segfault on power down of my qemu setup (that
> seems to have nothing to do with the CXL support. *sigh*) I'll push out
> an updated tree with this on it for testing purposes.
> 
> Thanks,
> 
> Jonathan
> 

All good, I've been wrapped up in other work.  Just ping me when you are
pushing a new branch and i'll gladly rebased and address the notes.

Regards
Gregory
