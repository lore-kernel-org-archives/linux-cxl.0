Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE2C433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  6 May 2022 13:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349423AbiEFNy7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 6 May 2022 09:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiEFNyz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 6 May 2022 09:54:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC851E55;
        Fri,  6 May 2022 06:51:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246AGxJ6024988;
        Fri, 6 May 2022 13:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=5w2aJi+Gh16NcRCQq57ZeTrprXYUM8unqiotPlIulUE=;
 b=Zx7Td7at/z8Qb9WdU0595UN91l7eiopbRjmvc/CY2t8rUqfqajBH3MWWCNPSghCSBSLx
 D3Ov2KXqyVqh1xigExddwLFV6Y8FZolty7UDE2/Cz0zuJowC+E6xgL/5H7kmGNEbri9B
 6q5eJKFIXIBUuZEfj6FO/dend1Y92pyuv+xY5OJNvUCBY/b3E8Kr1G2pVl4SUYERCAIr
 8VUzyVL1ft/TxyYA+QA9nMxbQYjI84Tbvqp45YPVJDUk+q4lvDxFXYnqvolDr4sQ4Biz
 8dON+RitXHwmdcaqSUAHx90J44cmZW8DMs0+8mzsLPLfLUaLF6ttgClQMH13ee7ZaBIY Vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2p5fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 13:51:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 246DVSYj032868;
        Fri, 6 May 2022 13:51:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a8by0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 13:50:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPtTIUS26CgJQp90SUaRj7dtMe91WKZdHz8clPW+aY0sHk+Qlu4AKbM4muAakGaAtmxp33sRngHuPXSohHKxdUwlcBDSIj/UCwHvxj34HT2XKgzXTwQZa527f1D/6nnCznnv8kN3P2TlSYrYanyfa2SkVHJNj+iSM35mwQNoGl9mWwPMqbWVn2OKjk4f7SRiCwCytRyGtJmyjCQGyq8B3zi4KfB2fl/2poE/c4fvv1lgSzuv627PRl3ngfbfsvg7f62RpPMcEhOj61yQ0J1Jp6vHVdFHw1OMrvcJaiPEFdIhiTf7qcoaggPbwkX2CiSeu9/CuRkYlKECZ4ee0tIRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w2aJi+Gh16NcRCQq57ZeTrprXYUM8unqiotPlIulUE=;
 b=B2T5kKtYx0WijBGXOumQjffzcUNj0CqMxTzOq7wmpmrfQKFMVtocuAYyZpSL4D/wMvOKOVIhy24Iq90ym5RC9Jxu7WZMFtIwf8vLGvF6o1qkWwnyl7Igi7s11uqQvZVQQXiaZjiVVShUl91+HK9dgCpmy76ILJO06A0czk70zQB/NiFd67bIvgW5KQdhgQmGH+XlZ3bxVDpIL8Lww+0zSr47EGnS0CRYD49FmQaOfIOtOZIbHUoycezZiHwhmndSRjJpMJ2NdB43He/1Uf0G6+jX+BLBmFDvZzSwD9hVaPZZDt1vzogyjvxRBAyZNQaL8Fd9I4ElTiFKTZZLDU0WbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w2aJi+Gh16NcRCQq57ZeTrprXYUM8unqiotPlIulUE=;
 b=Ey9myiOq933ivbvaNOgRuamOQzO2hI6o9bHcTBbroSHVxhvSYf6ffALTxT0AnLtx2ZtU7YXHVYK49T3F1p/sBN8Bt3g5vLQFpVnVSENwoOfAykYlsmHV8sQwFmiG2KsKkfTqDzxik4MG3DoVFem07Vt8cS4i90Wkkh4E0KW2R7k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4577.namprd10.prod.outlook.com
 (2603:10b6:303:97::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 13:50:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 13:50:57 +0000
Date:   Fri, 6 May 2022 16:50:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: fix logical vs bitwise typo
Message-ID: <20220506135045.GF4009@kadam>
References: <YmpgkbbQ1Yxu36uO@kili>
 <20220429023700.GA1320788@alison-desk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429023700.GA1320788@alison-desk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0077.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 829b13a5-6f79-4499-9d07-08da2f677229
X-MS-TrafficTypeDiagnostic: CO1PR10MB4577:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4577FBAD72CCA165F30762508EC59@CO1PR10MB4577.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6vpDzZ/yBuL6NFUA33K86moWH+/4QNAr7B3hdYuzXDWgV1hXEz3TB+rnlnSZFjrs3hM6RywnEjsZxy3uPpxubm2e5g/gmWdiS8FKNumKnPwCTa65FqdgHYTKaV1ZEzJM+m3DOTCR2hI4yxdFsNg1+aLP86hxd+/V2UfQLErBFtGcykNT9vLNqmIO11+4P91e+GOpEVIkyRr4eDzMr/Fwv7CBmbqZMSNN2+Hc2JXuDHCHdwh9v38+lQFNHi6oOYIBcFGm8qbnq5+BbTHNi0HCr253umxgW53oxX2TvUWpatO29V5Apdum6JleghIB+vs0sNKO5aVSVlNzYIfsnOHtOSQqjJa/oeSHy+/L3dITEVfVFmm/ZrIy0Daqk//iKIG5V8FGNLFk7vojn0wvn9atrT4JC80MXKhxbBluPJQ3VchI8aFloucr7v2te3oJiSYX3V44sRx9vCMzDmPV5b1Vl9sC8WZRLHI8PR8LXHos1iAcWtwE6d9FYZ4gD3o+qDVyrpCqt4NmCMxtuHwx8Y9BRPV4e/i0/8Pi1Bp8vH+atXeB39dFKb3g2YsGfh8dcDHLO9em79yTUh3To5pgN0+IaNQSGCO8N8vDTQfHSZN6ZV39TKiO474VeJErrjMyVg4wS3/FpVLdA3FyRNVpapSCUTquB+/zgaGNKKKjsUmU4C0PuTb8L9a3GZwbnBqBzZGx7TP1sFlhIgKpygugTfZHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(6666004)(9686003)(6506007)(2906002)(6512007)(52116002)(26005)(86362001)(186003)(316002)(6916009)(54906003)(33656002)(6486002)(83380400001)(1076003)(38350700002)(38100700002)(5660300002)(44832011)(4326008)(8936002)(8676002)(66556008)(66476007)(66946007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XgVMh4+HWm87T8+3gI18t87T5xB6AvHHwaAVwG+uz+cb/4F+g0M4LHcfTJI?=
 =?us-ascii?Q?f93jNqdZmJchZdHb5q4271RXvr4XIXyfeU8UPo+Ww+EKBbUTLlAHfqHyFCgW?=
 =?us-ascii?Q?+3PmUdBLCSDFv1mjPjnu5wmZliiBdjwW1X4CvEZ7vvvWN3oH5wUHw3WQOfB+?=
 =?us-ascii?Q?htkB+PBpPUemrX7Bbwn595rjFW4fOI777oFWodREwUKLouwyX9sezJB79hLn?=
 =?us-ascii?Q?iQb8dFDHKHmV/rb4kLmmYu+tQKD39kCe7W77LnNdZaizAAOv+Bz8x2akMCdX?=
 =?us-ascii?Q?sBWeDitbSbFx+NaNFs6Eh90HRWEMv7zis+ALa383TEop7zk33PBQUELd+BQM?=
 =?us-ascii?Q?0NN0vikP3/09pKQtR/g8oMXRzFEXFIJvr7WTex67QEGZiIwqhVjK4p/e6sT+?=
 =?us-ascii?Q?Va0KUy/dxwzmuhJDApUZiSzIou8rTGQdfsb5sVD7dz95CYQkpGGgAH/zCdFu?=
 =?us-ascii?Q?cz1IrebfRlX7u3aWmWVkoTCzyqd6BM11eRwtvPzGnzt6U7wjO7VeWz7SF9eV?=
 =?us-ascii?Q?ZaypPmRg9deAfE9FUvOPGLAc08eHOpqgpfDvRKkp3Tt+Hhc0WR9+yUDADhN1?=
 =?us-ascii?Q?3VomlliefFOIeSQuyfColsLmlJQGII4RxA2ScxZu3lza8o2HdQ8B6DFr6JDQ?=
 =?us-ascii?Q?/jcg02CswBY59QvJxbkMGGtpyp4ah1DLAIh4v+Xeo4xW7kMtw98HJiNXOMQq?=
 =?us-ascii?Q?C/5QbVjlM6S9p2m1KS0yxdfQwi1PbMTcnw4ZeExUOdPnOv2rbd0WB5J2agOm?=
 =?us-ascii?Q?QBjWOw/vielGAdVMtUm4JC0AT6IsvNl/3FBzClc7mWTJovS2dsL79ic2PbmX?=
 =?us-ascii?Q?2ZzuKb3dMDmYzihOwkIgGpq40AYYSG7Aj74bK37UlNtwgeWqLCrE29MWzEQp?=
 =?us-ascii?Q?ECGyp/3TjjCvSaRaqjkz2gQDCUhbcWoClybb4IgvbT1o5FhPFt1YeO2reary?=
 =?us-ascii?Q?JoH8JYlEyH/jZBy+gMzUrD1sAoVMbpR0uQ/VIm+zIs0l7rmicAzh1i+ic2m2?=
 =?us-ascii?Q?kviKTbczCSQmq3jHGyHt1o99bW4nOHMMJXVgFM/rXTH3s14y9kqzCBOnWI4A?=
 =?us-ascii?Q?uqR90+nkwGcJqWwM9qLVXG76T9rtb7HodrYYJ4NtnczmUx8am3etKm0OQjhb?=
 =?us-ascii?Q?SlMn2/3qLYT5BzwRuT8nMNFxXNhbvq8vmlRgsavU+c8y0ByymTJYWutW4Opf?=
 =?us-ascii?Q?nI2C23TTM+SdvKncaHZeN91ELHoTrYSqH61edZ/Vc0zGZeQbLxQp4EaNtOBu?=
 =?us-ascii?Q?n1dR4QJmhnPL4RUFNLla4F2eifaXnxTjXbLejGBfXLcG2JbjfsBFbOvu+tDM?=
 =?us-ascii?Q?SZZT7EMtdvNkcQuuuRsWc4TLGUdIkyFgiCbkOgDaDBfF0Kr3oTA+Ejgojz/d?=
 =?us-ascii?Q?i0sBgAtNIJYk7+IjLDUkJdiP9aAsbmoWgbwj61/6Tx78USYLr7YS4o0nVMQJ?=
 =?us-ascii?Q?3ItljhClPSsdOr5fkKIfUJIzhqOfvmSVEMMS12Kz4IdruL0IPC+y/h/tGno1?=
 =?us-ascii?Q?VSDWAUkPqx3SOD8GQ8EKC03npLpgOexAZ9249J3GVzjpgVXwge6F8jJdK5HY?=
 =?us-ascii?Q?UlZRKCBgN33/9DXrQtnifdKIasNVWri4sQABaLLj169dTv2rpa0IofXlucYL?=
 =?us-ascii?Q?//UTsVSTutbuMjYSwN8Yl7AmPdlqaXW3eN+HYzicQNnVxeUBhAwj81W7xhyt?=
 =?us-ascii?Q?aiG7Dhuri9QZ8+kqL6g8gES9ZUl1joW/6C8oldYN2lvwuoa+fjUE3zzVP/xc?=
 =?us-ascii?Q?e2l6a/FiZScqJ7+eVgJoGd5KgitY5gE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829b13a5-6f79-4499-9d07-08da2f677229
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 13:50:57.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiZ+hDO5plnSBfRztLG6h2yA2lSV6V4R7IVpR7+Zx8kfevTIb9jHc6JMX0mYM6K2myHdGMxj64RcRQuRud/u2julvu3LfIbivlYvRpMahk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4577
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_04:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060076
X-Proofpoint-GUID: vdqn-gxwBwGjkyXqR2t3x3EO6goBSjH8
X-Proofpoint-ORIG-GUID: vdqn-gxwBwGjkyXqR2t3x3EO6goBSjH8
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Apr 28, 2022 at 07:37:00PM -0700, Alison Schofield wrote:
> On Thu, Apr 28, 2022 at 02:38:25AM -0700, Dan Carpenter wrote:
> > This should be bitwise & instead of &&.
> 
> Thanks Dan. How'd you find this?
> 

Sorry for the delayed response.  This was from some Smatch work that I
hadn't published yet.  I've pushed it now.

It doesn't find anything else though.

regards,
dan carpenter

> > 
> > Fixes: 6179045ccc0c ("cxl/mbox: Block immediate mode in SET_PARTITION_INFO command")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/cxl/core/mbox.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 731cb43b570e..54f434733b56 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -243,7 +243,7 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
> >  	case CXL_MBOX_OP_SET_PARTITION_INFO: {
> >  		struct cxl_mbox_set_partition_info *pi = payload_in;
> >  
> > -		if (pi->flags && CXL_SET_PARTITION_IMMEDIATE_FLAG)
> > +		if (pi->flags & CXL_SET_PARTITION_IMMEDIATE_FLAG)
> >  			return false;
> >  		break;
> >  	}
> > -- 
> > 2.35.1
> > 
