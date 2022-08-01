Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B1EC00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 10:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiHAK5T (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 06:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiHAK5S (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 06:57:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41476B7E8;
        Mon,  1 Aug 2022 03:57:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271AnceV026725;
        Mon, 1 Aug 2022 10:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=MbH1X/JbFMh4WI0K7PtCWJSHFE85RNYYBf5qM8DpW9c=;
 b=W/pyUs2bxUIRuE6gmeR/L6ADsrrX4CGfmtVplCYVdCwkjgg4E+RQjQVoy1a+lEvmCN8p
 1PMQEzAwaQVWQ/ivHEG8cvTDp2mjzkYu5GjuZcy01rrsSLlAPKbD73UaSJGSjXGSqQ0W
 uGC6Qs72pfgWtAZ42/4KdgOfPF9p/Q2yJphyo3QOO3F3XHBD9TRPh7O5r8aq5S5MGuio
 LtjbqQODpppobThaE/k2gGJq35JljD3gQsOEmh32gjxv9EAHn9ikCmFOtjexks9qT8eL
 9cslH6woJfWvc8G1K/Iv75OCbduersgoHanld2wDmkPOmok4zVo14f3913j+YSkjqRxd pQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9k80m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:56:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2719Wi63031195;
        Mon, 1 Aug 2022 10:56:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu315v3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 10:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWIYGWqWyWL8I5iEoCUmMa1OnCw4CI2xldOlvDlVDwceodKswts1bfJ36hxNdSJKqM+it9dV/R1W63F3XX5TmhhyKouWV+q5aKrfEBPwJJJYFcChex+1eavnz3BZPCo5gssWHpqVE+9R9JOcR/U4S3/vXKYZ2Ajn/+kSrLTFKZJkhEXy4UuI7W9qL3Ga9hBdujNh9KRsnBgU9NoQNN4EOIVCvfsDyFla9MpuNrmAJLWpzZZ9Z9JjiJcm2oGW/b6LDED3lTikDcwAWRho4oDi1LTNUjedZoZUUEVbk7RiK+M15uDmGJUTPv0dNHkclCj1LtNiN9VCnBRNlefPeShI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbH1X/JbFMh4WI0K7PtCWJSHFE85RNYYBf5qM8DpW9c=;
 b=dHiqlMm5cRdEoMAYEzYGgZ2GQvdXqZU8regehIywkS+n01qyYk0DU/0HnJDVvO6kiGXm3X2Lfvbl/FU/jDG6wRZbXj56DybPBCedLrd6DyppbQyJBpKl1oEMGbeNX5hE/WnIq/uKisRJxqcPxql+ujXqgd5LDoNwI/gYVh3JasqZ9pDUfG/jZxVzuVDMpUQxFj+57Pq6UKBBRZARniRIcpWAjENW7TaA2lNhCaLR9Wk9W8bcDsfjieGMEenVUxnmPQUhRusrTb1MK9eUGIkLhk0FOKJeF6kN+3P6S9LoPgneo4b53BOc/29nYHRjmSN8NZsGTYgFHwj/8bPYmEN1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbH1X/JbFMh4WI0K7PtCWJSHFE85RNYYBf5qM8DpW9c=;
 b=lbYClka8GK7rX0E0TRJxZDsjuCsgKz9beomfpBZzkg0puXx1XMd63AGmKJ1Mkh4P96FaMU5SJFEREohm1KQdEY9g9LxK2D2U/T7svglKyYp6VA6ie2H2kZgMJ0w2MGMtD0H9kL7M8TeZukMhxiMwCYYuk23im5Nr8tgzJu5fifM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4252.namprd10.prod.outlook.com
 (2603:10b6:5:215::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 10:56:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 10:56:36 +0000
Date:   Mon, 1 Aug 2022 13:56:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] cxl/region: decrement ->nr_targets on error in
 cxl_region_attach()
Message-ID: <20220801105626.GC3460@kadam>
References: <Yueor88I/DkVSOtL@kili>
 <YuepCvUAoCtdpcoO@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuepCvUAoCtdpcoO@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0128.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adaa4db9-506a-484a-3817-08da73ac80e0
X-MS-TrafficTypeDiagnostic: DM6PR10MB4252:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: um9LocmwCwTRl8TmEQnRbxflxIwkgiGgxivCqJN8NyIPCt9wb25ai2H6q/i3oc7uIKcKgsXDa3gKofg5EyFH4GjjnHVGa43jYZZKmEf1ePRx2FqZ2aEACQ2UJgztCkbaAj7AfnCCcbw+rrrHJDsMDZfliK+vPd1YCG5eFRlcSwUQ/gZYQlKpBZaEDh7Soyrr3kMNHNyasBN6xqbAdmkaYrpAJh43zFQsA6fqPKXN0ZrXdCtbhp0hJfrxv3ctZ0XNuwfmypuBIwUsTj60xcQ15W0CzbZvfQy/lUdhpk6YPatyaKoRKhLxFtBkLlB24+Kxjkx5PHkuwi/llggU7vcbyb4QLY2CRs/HoUIyHVFxWCaVLoy62FAEZpUk7MEpcdyjGKGsNkikqsGxX/hbqFLyZcfsKtI4kbju7fG1I4NZM061Tn8YBSoAckB3IHdvM/F9xCj6lhKDrbvfvuiFwDr4agoQ9ieHx8321J3JKPO9vH4rxzsQ52Inatp8Noj5A0DCssLN0aNrRF1257VLFWYAFM0BOdTjnmEctUMLiQgF0VPVUyiroXhWncAC8+6xv+f/kapSho7wiUed1hH1gQBt9J+XajkEbRPgWWUAwFrhy/3VnjiML8aXCY7L/C8zIJaWlCGZvQ56ecoZUTpvF942M2BjGRgMvS4ZKQvr+KrtCfHCe43KREbZRiGwP/jS13Snb7fubDDdJfDhSDH6uCzOEInhMm3t8BzKtcubGGtFn0S7a/vd/TRuFprzSXafRRUOGWQrqLUTwx1z1Jyr4m0Yp7l2zKn+0RiR2SaHoDk0HczXGjJlFt5XtKJxWO36xzoo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(376002)(366004)(396003)(346002)(33716001)(41300700001)(4326008)(66946007)(66476007)(8676002)(6666004)(52116002)(33656002)(6506007)(2906002)(44832011)(38350700002)(38100700002)(26005)(6512007)(9686003)(8936002)(86362001)(186003)(1076003)(83380400001)(5660300002)(478600001)(6486002)(66556008)(54906003)(316002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZwF3JCgEgYeJ6u9sDsz7f6dla6cEwYoazZv4mMR7IMWsmBdTauccGeODCVsZ?=
 =?us-ascii?Q?LC5Ez0JMmVzZ67OJ//fDOiO/YILZCbL1GzqP+2dd1FPnT5pIdToVDVTGLRMr?=
 =?us-ascii?Q?CYaEqG9VVf1J0TRDslepR+lh55zNxpL2KF2lOzw9hPDZxyhQd5NNjnP61RWY?=
 =?us-ascii?Q?sz4tP06QZ3wWEGzvz0msvBYzG9ZutWDa/QvPk6y90x1lgQqUizm1uFEl1SWN?=
 =?us-ascii?Q?uH/TsZKbbSANl/ZssGEY4f4MZK7V8hWZqiuMms4L9TqP3bi1QM7hdcoQ29tP?=
 =?us-ascii?Q?PNz3xYNJFxNF0Ktv2sKyjdjlqQRoB5EISr8bETwCbDSCNatVeyf9FOOXboL7?=
 =?us-ascii?Q?2mx8Y1Wo7f7ISHv+4/z8sI6qp1aYHsIQpb/806R0TLsr6tSQY32KQpu6Q4Gq?=
 =?us-ascii?Q?QkApiTllwBaRSQHDfctetej2ewzWejvpBwW/V3WCHTYzJw1VsPVHqac7NGtd?=
 =?us-ascii?Q?O85NNWSAOQfLUDdQh2T+7tYWPlU3onJSByvznVVNlxnKmx8WLm3PKsfoUz0j?=
 =?us-ascii?Q?DrTJ/qsna7mLQmOa7HVuBSZqvJV9aKXm7m6C3d3lTdVizm2j+6XcdNLfr9C2?=
 =?us-ascii?Q?bu8SqxojiLRJtwonl3dEN/KyW93DdR3+zDej8Lm7HODfxiQ1JEZfQWiaIrkb?=
 =?us-ascii?Q?omIx4fmEYVgzPfbiLS8hO/UNLSSL0ZFSqbAuz2cdHfodosidxseiSn29tbZd?=
 =?us-ascii?Q?zyqC3YZew5Wvb4NNW42L0CG5s35kfaHL+8b/bocknYmaNIxJCwPY4nyZh9MD?=
 =?us-ascii?Q?mlI2qySnIUTs/gBVfpRJwlFGfXUcb1jAAxhN55C4qWvd8Fns1SnfZxAU+03A?=
 =?us-ascii?Q?9KBiRQYwUscBYAM+/zE1MdOuumT1WNSChOfYqUT9QUaPgY9BSifblwU3+37F?=
 =?us-ascii?Q?SMAHViEPIYCVsnpP8b6ql7VRe5WhHfPYxTwE93gZJakds/KfG7E+09ezxVaN?=
 =?us-ascii?Q?dgKuO9toSh8a53mfNjcwIsrw+0/QphNbRCnc7Jcye7N3F+zExC/IhcuYDaRw?=
 =?us-ascii?Q?BuksY7V7ShNSQ/u26ywetx2PY4fburzj1fQowZHH49Ow03L4s6QHOzOLb0Zl?=
 =?us-ascii?Q?xJn/y2t/Yqj7Z3gfRnAn+mvBAVNEM6kut1vuURNxaok/UbeWjM01XDEBjH9w?=
 =?us-ascii?Q?XMNK6Y9sJPHhYMIbeuvR/2LKdFvNXpNEGHEfapI3fsuU+l7M3Ob/+Rx+da9J?=
 =?us-ascii?Q?WgDIcY0jJIOBe+aSbg/UVPgNL1NX8ekh9ahWg67MKBi6TW7lQB3ZI1d8wD8/?=
 =?us-ascii?Q?I0fd0MONPBCehG4TbQQ6vXaQNtk/zuz1fg5WyYQEwvmBn5jh8pwMjDP62yTw?=
 =?us-ascii?Q?xRzxf6als7o7tQPEfPWc3NLf8GD/Azf/bdSQ/zLz07wIc2+cVfHmV6XsMCNW?=
 =?us-ascii?Q?rsI8xY07WQR0FNhehe32RSfTbBs4wAAZdIuiVdWI9a3gHsU20PRibbgnnUlt?=
 =?us-ascii?Q?TPOZ9EauTiz/prRxBft9kF18OYZ3kT4EGiIDxFC+HZkjfF4kXBk6E+ZXwa5B?=
 =?us-ascii?Q?tKZLtxnqXxfg3LIC3CaxzeVESttR3h8M47ltE4QVaED8V7vT11+WIOD2Q6zf?=
 =?us-ascii?Q?jwwsD/ba8j1oM4ZeFiP1tV8M6tH+TMM/9MJhXsKCnip5887QD4YCxyXAaIVr?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adaa4db9-506a-484a-3817-08da73ac80e0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 10:56:36.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+Vh6otejNzKwJnt9tSAvVeETwIz0tDZQ8g+5XylgElLDLFEo0adA9ASOHS8Fh5SEhYHSvTD7MpdJa55WpiVyGi7HOGdWZzYgnGbLNkHYrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_05,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010053
X-Proofpoint-ORIG-GUID: G7saUmK8NCqHBXbW35iELbvgAAyEgBJR
X-Proofpoint-GUID: G7saUmK8NCqHBXbW35iELbvgAAyEgBJR
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 01, 2022 at 01:20:58PM +0300, Dan Carpenter wrote:
> The ++ needs a match -- on the clean up path.  If the p->nr_targets
> value gets to be more than 16 it leads to uninitialized data in
> cxl_port_setup_targets().
> 
> drivers/cxl/core/region.c:995 cxl_port_setup_targets() error: uninitialized symbol 'eiw'.
> 
> Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

The error handling in cxl_port_attach_region() looks like it might have
a similar bug.  The cxl_rr->nr_targets++; might want a --.

That function is more complicated.

drivers/cxl/core/region.c
   740  static int cxl_port_attach_region(struct cxl_port *port,
   741                                    struct cxl_region *cxlr,
   742                                    struct cxl_endpoint_decoder *cxled, int pos)
   743  {
   744          struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
   745          struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
   746          struct cxl_region_ref *cxl_rr = NULL, *iter;
   747          struct cxl_region_params *p = &cxlr->params;
   748          struct cxl_decoder *cxld = NULL;
   749          unsigned long index;
   750          int rc = -EBUSY;
   751  
   752          lockdep_assert_held_write(&cxl_region_rwsem);
   753  
   754          xa_for_each(&port->regions, index, iter) {
   755                  struct cxl_region_params *ip = &iter->region->params;
   756  
   757                  if (iter->region == cxlr)
   758                          cxl_rr = iter;

Should there be a break statement after this assignment

   759                  if (ip->res->start > p->res->start) {

or do we really want to test every ip->res->start?  This loop is
confusing...

   760                          dev_dbg(&cxlr->dev,
   761                                  "%s: HPA order violation %s:%pr vs %pr\n",
   762                                  dev_name(&port->dev),
   763                                  dev_name(&iter->region->dev), ip->res, p->res);
   764                          return -EBUSY;
   765                  }
   766          }
   767  
   768          if (cxl_rr) {
   769                  struct cxl_ep *ep_iter;
   770                  int found = 0;
   771  
   772                  cxld = cxl_rr->decoder;
   773                  xa_for_each(&cxl_rr->endpoints, index, ep_iter) {

regards,
dan carpenter
