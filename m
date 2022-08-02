Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A52C19F2B
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Aug 2022 06:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiHBGoT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Aug 2022 02:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiHBGoS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Aug 2022 02:44:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343D48EA2;
        Mon,  1 Aug 2022 23:44:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2726QRGv013644;
        Tue, 2 Aug 2022 06:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=EzAxLta1jicCglm6QzkopIueQ1vNthAGIiaWz1ih9Lo=;
 b=n4AGOXuJvdta9R96j++8xfle7NDhQOybfmohzRTMD4rPdEcLQ8bpi6Ws/YNY+qmyFtls
 /Qj5hvMb+SOzabeioYlw/Mzg1ecrgf9YsjE8tTXoDMoGnwFuT86o81Gu+kFOuxb+9k24
 7HGgw92b3uZX1WwBNMx7TugkxkN6exBNiWT08eW1kfwUz3HZJbc3Rl8KC90cdnidoNLe
 +pqAOtzj0KPC5Yq8pf8O2f03ga61rzfSc+dM5J1Vuu9EJAnItcft1sY1LIext2xF1Egh
 dyxzzLVxxr3WB6uQruP6lkz4OSxMbFXXIfp98CAv0xBT40Bgd7ffIfVY5cCiSPFj9X2C 2w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2c5qrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 06:44:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2723uJSY000860;
        Tue, 2 Aug 2022 06:43:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57qvxmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 06:43:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVecZkCFC01CMnd5jhDljkJtF/+YikXyE8/7+UCjwjeMiM6N3/b+005oKYp/aajXtZP03ObhSzAI+QJ5IhDc6ojNySWkpLaX7CwWA5CZ+sPmzpNQ5oGZdt0+ApDL34g9q4NVtTt/xFDzszAH27gnbow6Pp3+bXLgxq9kLp4T2ioU1ELZ+8BXcSDyUVV1MYFH7EtDc4b4q7THhDbnmkP1y9Qjz7byKS74IGyKehOBc+56eRxWIQULPSQSTo3t3K5PoVNIP4wFeQRqVPaRaM7xTfN5TF1/uWbq6i8WBaueVcXWcVc4cgciIq9QUulgxTZnZDEzvueWm6ctf1I0ZX7Cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzAxLta1jicCglm6QzkopIueQ1vNthAGIiaWz1ih9Lo=;
 b=hZUEEIfX417700x5gjjecOiif0S7KyIbYivj5XrNnAyhSANmADNrEIthq8pbSOEZoqxXBF4GcuB9mX6IlmnnCh2rZOwbjPkl0FHe7bIqBrTdxPJforVEZY34y6kbf+p8atvbeN7axFKU9dHr87tYP4vMMVuju9jlFnjaSphT3r7e/3noCkURrrMCQuvzzzAYcgMDZUDmVmMMuckGvL4rQocoGbw6cYTa0yAf3emEFTHauUDsYSyTEoivWSxbHw2V2TvL+mBhH4LPh1jkF6fvjWjVnLSsnp65EA/NcvTdjm/1m7Nvu96yc99j8MXeAxWP80fII5xjDeHQ6H55W9pBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzAxLta1jicCglm6QzkopIueQ1vNthAGIiaWz1ih9Lo=;
 b=t1mQPXa6RoNQEHO31jIcl39Sy1SZLPecrGPra4PjH9bO8vPFd4K5HoPH+HMigl+gelmjmXBbxPPFm8koahlJYG3i8A3A9PHCJmRuOTRc7yrOXoG+bV2Hovv2zzKhpDINr4OpSkWpUGCPFByvG+zFcAE+DAHMCJwRzQguN0gyv+0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1978.namprd10.prod.outlook.com
 (2603:10b6:3:111::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 06:43:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 06:43:57 +0000
Date:   Tue, 2 Aug 2022 09:43:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/region: uninitialized variable in alloc_hpa()
Message-ID: <20220802064337.GF3460@kadam>
References: <Yueor88I/DkVSOtL@kili>
 <62e824628507e_b0752943b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e824628507e_b0752943b@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4705109f-12a8-411c-dd2c-08da74525ff8
X-MS-TrafficTypeDiagnostic: DM5PR10MB1978:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lg1YDrjOXsfJgImUiTXRGkA2OqYBUV1ZnbYMtTCv4kzmDY4fTvS4Ql4jZcw1y8LmD+EX20/sHMtpl/fFquqbYzfsoXBlVaxnqqkYsvYIDygKLV3IN7kFHjaTb7Sv3cdiFOVtHwUyNbqQTM3g2xydihAnOzF9jIuE2Gbmg3HUk3uLAZi6v2TCSMX2GBm3eOXystKcGKEN0p8X7tzfbKcRWirnow9NrS/tocQ0kl6eCpvVJDayOwIgUJhnbZpXjweCiB2glRMFiikmrnD21amuraxGhQ3LMfaiwsvFW+dv8OR51zDeYQXZ5IcxTJxe2u/LsS+iDcwJE2AKMj5VXtyWiJx/yX4ImDxXvhqWG9qqVxPQ6bOcGbU2FAB9X1gtiNxYGw840Gtr0SL5pTOuw8ckdhp8TjQb9v2YyvRFaS3pvj5zujeaEEwkpBRCstl/Gs8YJfFnvpdtu6A3vKwS7YYqADaG3GZ+tldDPX+SdICJyMCWKKO9jZzQH579Tx+9uLKQKSxUp93ybtmSErnh4ePAJ+FxDs/qf1wl7Z5Af70GEBMHPVLnmuD4Sw6wdivxmoqyttMLGXRP/pTXjBtmbO8GNT60XUmVQ6mjA4CqK1HZCtvhsW2HWXE0xI2NxuIPas9SCbei9g13Kg33Gr8Hmcz4fiyEBGsn4kKYpTj8k5yEY50JC7JCU2Kt/irO6HWYgVeYtwXr51cB5VFF67sVnlCrRVuCKcZUbJL3OTPeMmTYHaHmL/5tOi5813fQAA6LvELyr4BiFalWYQQq3+Mb+75bUVnnnfJTk0XRKaiIA1bFEtc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(346002)(396003)(39860400002)(136003)(38350700002)(38100700002)(44832011)(33656002)(52116002)(6486002)(66556008)(6666004)(9686003)(6506007)(6512007)(26005)(41300700001)(478600001)(66476007)(5660300002)(2906002)(86362001)(8676002)(83380400001)(4326008)(8936002)(54906003)(316002)(6916009)(186003)(1076003)(33716001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cn4EVsIpkjpcOLB+G4MVS7XNVnm+FJv5u/XmTQRLcPhEYA2CXXnJIv7RCmEJ?=
 =?us-ascii?Q?Z9tZgy9dsOLYN7rRW4Te19iqTHxLveMD+jvkSB//vhEzmRPOfaT+DeipMF+P?=
 =?us-ascii?Q?cRm8SPMNWzLXfQvBL7wdc/Pex8mQDGrn0R2tfSDxLkd+MQvSS9rKOSpY8T8V?=
 =?us-ascii?Q?3rys+j9rYE5qSdegFgIh5bmTS1dJeq0h3mkmp/bYvOZvz+Y46WJdXmWLxV3C?=
 =?us-ascii?Q?3FCQf62w0lU1EHsCdZG120NDtU2VxWIqBvGEFgUXHPowZ5ciN/o8Gw/tqjgV?=
 =?us-ascii?Q?NHuqzc0ivhOTDHqz9yQVUBE/7YFxwUVG/WD1JMMIM9HeJptwZdiP1ftzcbv4?=
 =?us-ascii?Q?fH10uhI//X7Qj3PzJImXd2JuxzTgPiyee+y/fsJ8f85ARUmK6HO4yby29Bii?=
 =?us-ascii?Q?A8pE3rKO5+pTvtoC1H37kcY6PsRN3eh9wK5cGvU8tpAdqQysk3y0n4RCTPko?=
 =?us-ascii?Q?0PQx/b+nA7IngU9akrfSSffYh3HapwO/D5dd68/4JdopnWIX3tY3qzk4EZaR?=
 =?us-ascii?Q?FpiPm0WPNj9+QYsQbFDe8pJNxFeQn66YKqymWxiiipgsMD/xmCbGK7t0nOq9?=
 =?us-ascii?Q?FQGLAOvPSM13JKVS2IiuZ3BiyjtybTC+/xKDmMLTNJ6LL8FgBi5Xrbqy8PYv?=
 =?us-ascii?Q?VHQGq+el/yD3Wf6jOyPP5tDoOiOnotCRfXz+BGuKWiCVFRWi1MtqosemiS/c?=
 =?us-ascii?Q?IRMiRCa7qoo/sJM21ZFpDC70t8YPjnErl4x1aB62XaR6pBuQKUkX8sMbddq5?=
 =?us-ascii?Q?idLoGlrQZwzCsSNAC1z4+7/sdqtXpDtRpTIWjm+GfFzDHeXczvLPWzqRdsLO?=
 =?us-ascii?Q?UxBTTuafnDJcJ+VrxQ2KEN2xKTbFnefZQ1gnH+E2doKfbO252kpR21OypyLl?=
 =?us-ascii?Q?vxaYW0OYY6z72JnlgT+81D30Nb0p7yF+ZgPpM5McIbozI7f35HfR5qPzRM57?=
 =?us-ascii?Q?v2QdRxw52eSO/4/U0+1XSPWZ4CH1N/roA2IGrP/bkLLShgVK0D6NsS9/Sbq0?=
 =?us-ascii?Q?S8XVqqlx8wQznBuU+UHX5f/dQGTo8+wNsIus1vgJu/fYpOuzdOblZ6qG2CmI?=
 =?us-ascii?Q?sC48uVbzOC/D/mryNMmT7nJcNboGQM16QbrX7vlgM2f5pg9BrCU2FP/SpF7G?=
 =?us-ascii?Q?UNb4cDWG3AMrf1x3uYGcAakOUxPYzU0QsfxiXCxyg5uprxJSkhgmX7/SI6ST?=
 =?us-ascii?Q?F/2xeLC1+FFd2CJjww7aZNuNloKzMaRcB5XRw3zGqnUV+8AAyGeBm9nFWFhw?=
 =?us-ascii?Q?7xygt52GX1nEAoAFkpBQlax6A0Zac+M2TJkQLkNr0Q+K53sC55n6GeVAdS4b?=
 =?us-ascii?Q?fnzt1pYi35FOwFRlMU2vSAZ4X1j0mNm7LBwHO8ZWyqudXP/aI3lJP5CPJayr?=
 =?us-ascii?Q?IwI6TXAq0Xn6l9AnwJUQ1sgg1QF58kNkRM7uyQVifCiDt5iAjI9EjJKylXbO?=
 =?us-ascii?Q?8dGhiZgN85VXwZU3ep2AJ5/IhnN+htnRvXwX6FjqRGZYuoq/iX3sNJ5qrzbd?=
 =?us-ascii?Q?NgVtH5OgiGyDQzydWpVK/ttjsW6XpyeFqpB1fT2ixtQDbcHRwugpURBhfSzR?=
 =?us-ascii?Q?UIHTLH3Ma54sKlKQg2LiaWm8G4UEIl7RQ/mTYewPM5tfh/ER4s1tHdUdIrv2?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4705109f-12a8-411c-dd2c-08da74525ff8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 06:43:57.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0w9oEZZvkp3popNXuIYQCYYya2Jx97+gYmmbxV+kdFBnZqQ+mGLotra6/URD1dgnfV0Qh+NCZUVuYV8Y8wA6U6AYVjoUUSR+AVNJtg5ogXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_03,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020031
X-Proofpoint-GUID: vd5ssaBnBK6S7_F7Fy3L8oSMm2Ey4zrG
X-Proofpoint-ORIG-GUID: vd5ssaBnBK6S7_F7Fy3L8oSMm2Ey4zrG
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 01, 2022 at 12:07:14PM -0700, Dan Williams wrote:
> Dan Carpenter wrote:
> > This should check "p->res" instead of "res" (which is uninitialized).
> > 
> > Fixes: 23a22cd1c98b ("cxl/region: Allocate HPA capacity to regions")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/cxl/core/region.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index dc71ec457608..c80932bca667 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -454,7 +454,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
> >  	lockdep_assert_held_write(&cxl_region_rwsem);
> >  
> >  	/* Nothing to do... */
> > -	if (p->res && resource_size(res) == size)
> > +	if (p->res && resource_size(p->res) == size)
> 
> Yup, looks good. Surprised this was not caught by my local compiler, or
> any of the compile-test robots.

Yeah.  It's weird.

We've disabled GCC uninitialized warnings which made me introduce a bug
last week...  But normally the Clang people and the kbuild bots fix
the bugs before I do.

regards,
dan carpenter

