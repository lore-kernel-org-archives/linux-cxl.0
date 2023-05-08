Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D007C77B7F
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 17:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjEHRWO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEHRWN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 13:22:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B3949D4
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 10:22:10 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348GwZwi032102;
        Mon, 8 May 2023 17:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ELulAQuo9e87wPhEllvQbh06T7LsUSGBnlcutC0cevg=;
 b=LNndciEpELIHb89xlrnZSrhX4424xsGUZdwinI41QI1nvtsejPuzOgU4pYketYZJNwFo
 HW2Vpc6RXuX1aGAczaq6ni3ORLaim/t6bVf/0AFkZNHObujc8WOE8vx+W9aN5NozGKsm
 NBbWw7+9kGfk0BT+1PIk69W+OMYqcKcXo4+NB3N79F6Nhn7fDoX60xS7tc0z+Z4u1feb
 dVw0ClEpsRxG595/Bh5Geau20rSDurGqGbuhHaTfCFHYPIf87Il8IEEYFz9blTdSySIx
 44j13FLT7lE5EXXgT2YfVpl8eGXYg4YO4K/72JU9hNdx44sgJ429CyvhMTs/PfIj+mWZ 2A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qddtcm40d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 17:22:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348H5D02023387;
        Mon, 8 May 2023 17:22:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb51f5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 May 2023 17:22:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gunl+r1XqwWrOutP0bjq8ZMV6F0lFmNvS2hMBiAyF7F+jzZpq1bfU2i9S2JdPcOqTPkehdbAraFVxgYNt9+jEQhy1dWoI/fEu+ano+iKiHNc+qmIh8UhMjNQAdtSkmPoeNhfXjI3C/HhG8HbQu0QMnHjAO1UcKB/oo6XvzIurx+r+CIiR7BwVtZMmUQ6/qELi+jvPx5Q8BxQO1SOeEk1hLClESqY2+pmOcV7FmRGi1P8umUDF7o5BCygs5p6a2cdoUo679siA7cPvktpmVVIiMZzieedLiJv/t3vC/l2Ug+PShYGJNmQyh9cNkRcKjm+gYz9w+Muvz9fpPIAcY84Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELulAQuo9e87wPhEllvQbh06T7LsUSGBnlcutC0cevg=;
 b=Ui9LwuNkqNedjlv4WJ3qzeSug456DL3/bEQ8vtx62/u8tFfoaZ5I8YgQmQXMZarlrTRFSb1iadVM3FfR5YmmnF+/HMkSCWeaq92V5b2S41DnldPUgUVHfVlAXHFcYh071x8laoZt6QFyv/cYEsY/w44HzZCma5z4u8xDh4/4YyMmka7ZWR2nTqyGZ0i8XaflDZWi0UC7eEQzrfcCJKG8cuUaG4ELJTMK9KHerNHA9daxW3DEgHvTiwmO0dKIU7e71J8ydzpZAq7w/z22a8k8+ghpUGFLkxXN74vMcjFpTZog9h28evJuzaqCaKZYXxQKY1VSK5GhcVVbWVINrd9baQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELulAQuo9e87wPhEllvQbh06T7LsUSGBnlcutC0cevg=;
 b=duy/akw6hu9wjoebO91jgKqxmmFyTGTk4sfzr1yU3pF0rpxMC2mAZpJLBQj1iS9p0Ry+DeV2qXG2T0rqpkTLbp6xV2KcRxxNBUSCxNfZWszv00Lz+l1UOvHapUZftXHl9YpPtEPypUbgk5kMY7tEONDcaYhQYZONq2v3teRYR4s=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Mon, 8 May
 2023 17:22:06 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 17:22:06 +0000
Message-ID: <32e93bbf-a29d-148b-5f6c-859bcb2640a0@oracle.com>
Date:   Mon, 8 May 2023 12:21:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Questions on getting started
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <544fdc40-0ff7-690a-d24c-3939d69c0725@oracle.com>
 <645572d181c93_1e6f29425@dwillia2-xfh.jf.intel.com.notmuch>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <645572d181c93_1e6f29425@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: e70a24ac-5c05-4706-d4bf-08db4fe8bf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9icTlbOvQ8ZwB1lm49Ve7J0J3qqHTzVADbIqMvgGT84aTM8UgBaVViay3xyv9vAiFVB/kHxufCqJZPyN+6ohRFC+lsI9DfvGnXHS4OwRFm1pEO7BZNgvoj2O3diNs2bhp5NfIZ6w+noXOibWnkcr6fbuAgK7KK5baVjJ5A7+giGJVH80PKOmG0JKy6+wtWiEONL1pKsXoBPyM7onVqL4o46kVW9Lxahwx7DEhH9de5M63KDQyCCngJ1hCn7zT7IMMT5AIV1G6TQ/GmG3XRCkxL+L3VJ8u6SmuO15ob8ctgPY5J5C10WjTbsHPQUvTfikmR7qo+d3PGlFf/0ht+keZx22i56Od1Wflf3yQV0khewrdmVcKTei7PGsBxvcKAQsSK7VUvhOh64LzZRQsAiGlYlBGvzxC2ZQV45vhyjYn+Gl3LUgneZH8MoV5HJlnq66DHtLO/QqxoheJJ09GQlBEH9hrhzBRE1Qm0cqEQjGn6jadKO07DaLJ7VTxPCJLz9WNutNtGGkkeOMoPLMjTrFpd4Wk+02IDaJlRn46olmOqMD8XbKm/CJav9xlfn3sU5L2GfVfu/pNOmbL9SgsNYbSxQPMmtnK+hPCUNntyjrkILXsxbYBDQAajNTKrDRecSYCQ56SryYYstm6CWihKAN3iesOeumVRD1rTnn3ldOG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(26005)(53546011)(6512007)(6506007)(6486002)(966005)(3480700007)(36756003)(2616005)(38100700002)(86362001)(31696002)(186003)(83380400001)(478600001)(2906002)(31686004)(5660300002)(66476007)(66556008)(316002)(8676002)(8936002)(41300700001)(66946007)(6666004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW04NEFxNXk3QmxYTWx5MlR5bUdpLzZRcklTUmhSNlhIT3lTOVpTRkJSTE5F?=
 =?utf-8?B?TUZ4S3prWXg0b2ZBUjNsM0xjZGF0MllFMjBoN0dZbExSeStLLzV1TS9VeUN4?=
 =?utf-8?B?NUY5dDhSVUlZNW1IVXZ0T0kzeVNpUjI5NTJoZ0ZXWVBwR1lpMlYzL1VaT1VN?=
 =?utf-8?B?RHNQbldESFdXSEx4K2FId2ZGVDgzQkNFYzBlWkVFVTdld05CNHBIYmxDZ3dJ?=
 =?utf-8?B?MHFuRmkweTNWUHBUR3QxRXlPREtKT1pzQ3Q2VEZoNHhCdWhYdEZzUWgvT0tO?=
 =?utf-8?B?MVo0ME52VWZzWGVWNDFOTGJYL2NQemlpT3lnanlRYTFXZm43U0VmaVJTTHdM?=
 =?utf-8?B?T1FMUFBlWDhrWkJGZVNvNmV0Tk1jODZ4Y3FmY1Jxa2UyNFVGakVMMHM2RG5U?=
 =?utf-8?B?bDBYeVVzSDZUTlhXS0d6Vm1HTGJmYWZqUGd6bzQ2dDF3MnQxdUhxZFBvZGRX?=
 =?utf-8?B?cWRBK2NxLzlpOElVdW9pSkNxL2hrU1ViclpEWWpoVks1VUZhcVpCTkNnN3FJ?=
 =?utf-8?B?NGo0MFQ5ZUg5U0x1d1VSTEQvZ21zM2tlMkN5WTNBd1hvemFURjlXcHp1eGNE?=
 =?utf-8?B?NVdOZ2JwNlNkeTA1Z1JBNWVwVWVKTHd5QzFGa2ZEdW16L1BUd3FobnREYWdW?=
 =?utf-8?B?YjQzZEs2WENTQTJsbUxUd0gwb1JhYzdoNHhLbHVhbk9GOHJjSFVDTlUyZ09G?=
 =?utf-8?B?T24zQ0tkd2QwZEtNdkgrdkVVTlVaWHpjSzZSNlhuakU3Z1BUcUdIaldiMWNx?=
 =?utf-8?B?Q2JoY2o4YUVQL1dqQlpsMUhTN3ZVbmxPQjRnb2FqRFFWLzFWc1hOdTB0QVN2?=
 =?utf-8?B?Tm1pVlVLMkptQW16ZkQ5dmh1SkdyaWdHSGo5YzRkRTNwcUt3aDdjZlVoc3JH?=
 =?utf-8?B?V3UzZHZRK2RaODZUQjNwa09yYU53dnl5VWpMbVQ0bGcvVEp0YWdYZDBwKy90?=
 =?utf-8?B?UThUZkdxWlFsZFlTdFI5R1JMeFpmbG9QOTFOVDhtVlJzbmxKL3VISFI0V1Zw?=
 =?utf-8?B?QUhXUzgxV1o5RGFjSVg1UTdYQ01mK0FyNG5VYnBmc1JldlN3TXI5a1g2VWZU?=
 =?utf-8?B?eTRXNEdXa0NXK3pkQ2d6dzJsUENGTERlS2pjOG9YRU03R2NHOUxjZW11eVlN?=
 =?utf-8?B?di96WUYzYzVkeGE0c0ZPVWR2QmliT1VvTmwxOEhzakFNNWhRdTVUbG1jeCtj?=
 =?utf-8?B?V2dycUl6ZFF4WWNzNXFPYi9GazBBQVduT3FYNGZaUHZLQk9GU2FKUytVRDhv?=
 =?utf-8?B?OXM3QlRaaTc2RGc2S0lYV0pvNXc1WnJHQWw5bHpoOWJ0Z2JrV1liZ0dxa3Ry?=
 =?utf-8?B?VndvdE00dlVHbzIvbkdnRlMyRnBQVmxaeDFDOXNHaHRsWmlWd0hSS3N6eGJq?=
 =?utf-8?B?T1J0R29nWjI2dThpS25oMllWREhIQmRRRDFkZnUyNVpKV0U5cFBzWms2YUE4?=
 =?utf-8?B?VG5RQnppQXF6WEY4RlM3K3lLbmJONWN1dEt6RXZudXN1ejh0bVFaaGorTW5B?=
 =?utf-8?B?N1pwSmMwWGJ5Y3NOZTYzLzVOeGxOWUNKVXJ6UW1aV1VDMGVSSUh2M29lVVNR?=
 =?utf-8?B?VGVPWU56MHY3Q2pzZlFrdXZvYTFrY3pvUW9rdXlJVStqUDFCUFl2RlVTK3ZG?=
 =?utf-8?B?Q3UzZ0dWTzh5R0YzYTgwUTk3NFkraVJJYUJaUlNXSkJNVk9WR3JwTlR2cGpR?=
 =?utf-8?B?aWZOWXdwK2p6SjNBWnVMUEE1MUowUlFUMFkxRGpVeXE5T0RwNWc4R0RvdDQv?=
 =?utf-8?B?NDFQS2lKaW5jSDNQam5VamcrSWhGbTFZZXE4c3Q3d0c2aEpkUUhnOWRvUkpW?=
 =?utf-8?B?MWQ0ZGc2dDd6N0UwZXNGYjFTTVlXbTRmSFNsRlZpZ0RyU1dDL0VGUmY3RDd6?=
 =?utf-8?B?SVByWTJPd1pINzk2cGRCMlFxSDdNanE5VlplczVHb3l1UmVaY0FWZHJ5QlJl?=
 =?utf-8?B?aWNLeDJHejVHUTdhTmNpcWxEWWtVdGhObW54QWtYQSs5NFVRZXZSbXZEQ0NV?=
 =?utf-8?B?UW5DMHJYWkczeU40ZG40UWZkOHY3YjBlK1ZvTHY0MTlqdUREcmxLWFFQZzd2?=
 =?utf-8?B?LzQwSFVKODlyRE5kMldLaGo3aGk5N0lDL3hJc3orK1R5UjRmYXMxM3F0KzNO?=
 =?utf-8?B?Y3Q5UEFEQVNRRDBjbFNxa3lhWkFIWUFBVkg5ZlZOQ2NrbzZZakdmVDdveEJD?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F7vYWRerOQ9WucX4UI4GcCyv9In8ZKRGzv6+ITc9dhLWqsabRdZ++gd/nQpSIoMT2f1auZicFuuzRbn0/sMrQfQuuYuAcADUuJj5fgsaaNK8ElszvozdAuftoN/VXL+U5Ml7aIlPIEV9MJ5UluqM99cYiWEyaZvoDw/CosQUgtZtFItfKyNVGfUiB0E1LUomPWB2dcF6Xw7UU0TxHUU0zVPyNMB1UeEeh1KLk1C2ajqadZxalLNZ9iTs02vNb9E7fAlOPn44UaG3VVvmV3+ZYwZfUVlsi8nA3+pL7vmrW0kJILo4HTeq5N9kPkY3+nEGWP9d0ZxO9dFX0sy2BXRsN2zzXE8v/acfizmrw6deBKACj+9AxrrkBGxVSZ3YxRb/W4wiLfZi9JXpa2SZzHXDtrAJbBVBZwhqQUfvEAOVRvbO62F3OS3sg6FV5NkxNnSa49mxx+If0zuDyjMsxlxBl2BccTT0lpZM33i5a4p2Gy+rWf4YZuxHdvslF18OjqzOkxZ28PSbvv0GdDQIYEgnYAUGq63YxytkrhvCPp/EWXVnctUeRzNmtRxgZuZI1Lvlv/E+DWe4p7Yn3+E5PR383tNhXCb7f/ltYZ4z2K6U+VqwyLigYKzvZfNGWbmDWqLKg02IznZO5ZPezwBILq0ai0pJW5ZvWf31rnaayr3WJzVDdbWLrJ7zAKH8wG1r8Iw/DMt0zcG5/W/dohIXcnfJNOhFXjS3oNMrN8bcTtFqxbQJ4a8zA0dx1mHoSGjUjrrq8d4K26ECeGrIkpvnvv8oFrIAScDKYua/hCE78N/Mn8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70a24ac-5c05-4706-d4bf-08db4fe8bf36
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 17:22:06.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEP0iC465koh+UqYe/Q6UysMqjuFU4JxeXGDPqhnsF8JT3V3wfHP90cIA77j+ws7vB6wq9oDIKL/zO/+R2R7e71g2dYq9jahiOY8fhvAdBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080116
X-Proofpoint-GUID: WhGlV6Ef7RCzxuzPybP8YX2tzzYGQmMT
X-Proofpoint-ORIG-GUID: WhGlV6Ef7RCzxuzPybP8YX2tzzYGQmMT
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/5/23 16:19, Dan Williams wrote:
> Eric DeVolder wrote:
>> Hi,
>> I'm new to CXL
> 
> Welcome!

Dan, thank you! I'm keen to make forward progress with CXL!

> 
>> and have spent time browsing linux-cxl traffic to get an idea of where to start. I
>> thought that running the tools/testing/cxl was a good place, seeing as I don't yet have any hardware
>> on hand.
>>
>> Through various nuggets within the linux-cxl messages, I landed on the following:
>>
>>    https://docs.pmem.io/ndctl-user-guide/installing-ndctl/installing-ndctl-from-source-on-linux
>>
>> Following the instructions within, I was able to observe the running of the CXL related tests.
>>
>>
> [..]
>> 6/6 ndctl:cxl / cxl-security.sh             SKIP             0.03s   exit statu7
> 
> This skip is intermittent and should be fixed as of:
> 
> https://github.com/pmem/ndctl/commit/82a0cda5
> 
> ...were you running with that?

Yes, I'm on ndctl v77, and verified this commit is present in my build of v77.

> 
> [..]
>> OK! Now, if I repeat the above steps, but with recently tagged 6.3
>> (perhaps thinking it would yield a passing suite):
>>
> [..]
>> at which point I've lost the system and I have to reset it.
>>
>> I suspect the faults in udevd have something to do with "plugging" in memory, but I don't have any
>> ability to inspect after this point.
> 
> Yes, good insight. I have this setting locally, but the instructions
> need updating that as of commit:
> 
> e9ee9fe3a9d4 ("dax: Assign RAM regions to memory-hotplug by default")
> 
> ...the test requires booting the kernel with:
> 
> memhp_default_state=offline
> 
> ...or building the kernel with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n
> 
>> It appears to go boom when attempting the first test in the suite, cxl-topology.sh.
> 
> This is because v6.3 adds a preconfigured ram-region. The test validates
> that the region is auto-assembled and ready to be onlined. Given there
> is no actual physical memory behind the fake address ranges used by
> cxl_test that final "online" step that would happen on real hardware
> needs to be skipped.

Makes sense. I've confirmed the commit is in my v6.3. However, I still observe the same/similar fail 
with memhp_default_state=offline (and I've changed the .config to 
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n as well):

[root@localhost ~]# cat /proc/cmdline
BOOT_IMAGE=(hd0,msdos1)/vmlinuz-6.3.0 root=/dev/mapper/ol-root ro crashkernel=1G-64G:448M,64G-:512M 
rd.lvm.lv=ol/root console=ttyS0 memhp_default_state=offline
[root@localhost ~]# cd linux
[root@localhost linux]# git branch --contains e9ee9fe3a9d4
   wip
   wip2
* wip_v6.3

It still fails in systemd-udevd which suggests that the hotplug online events are still being issued?

I've tried linux.git tag v6.3 (the wip_v6.3 branch above) and cxl.git#next (shows as v6.3.0-rc6) and 
both behave the same for me.

I must have some other config item at play.
> 
>> So some basic questions:
>>
>> - Should the above sequence work with upstream kernel?
> 
> Yes, and with memhp_default_state=offline and ndctl v77 I get:
> 
> 1/6 ndctl:cxl / cxl-topology.sh             OK              11.90s
> 2/6 ndctl:cxl / cxl-region-sysfs.sh         OK               7.32s
> 3/6 ndctl:cxl / cxl-labels.sh               OK              10.58s
> 4/6 ndctl:cxl / cxl-create-region.sh        OK              18.40s
> 5/6 ndctl:cxl / cxl-xor-region.sh           OK               4.76s
> 6/6 ndctl:cxl / cxl-security.sh             OK               4.23s
> 
> Ok:                 6
> Expected Fail:      0
> Fail:               0
> Unexpected Pass:    0
> Skipped:            0
> Timeout:            0
> 
> 
OK, great! I looking forward to reaching this milestone!

>> - Having noticed that the nvdimm.git kernel went dark, I thus tried the upstream kernel. However,
>> from the mailing list I learned about https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git.
> 
> Yeah nvdimm.git is only for dax and nvdimm maintenance. The branch you
> want to track for updates going into the next merge window is
> cxl.git#next.
> 
ok

>> I have tried the same sequence with this kernel and a various few branches/tags. No luck. Is there a
>> branch/tag here for which this sequence should work?
>> - As these tests utilize a mock driver to emulate various cxl component(s?), I have found that there
>> is no need to run this on a system with CXL components (ie real hardware of qemu), correct?
> 
> Correct.
> 
ok

>> - Is there other documentation for learning how to run CXL tests other than this pmem.io ndctl write-up?
> 
> There is some automation for setting up a VM to run the tests in the
> run_qemu project. That builds a kernel and root-file-system and boots
> with a canned config that is expected to work:
> 
> https://github.com/pmem/run_qemu
> 
> I tend to run a custom VM and give feedback to the run_qemu project as
> needed.
> 
>> - Is there a better/preferred way of running tests beyond this? I've seen reference to kdevops, but
>> am equally confused as to what it can do (in part because it appears to use the above mock modules).
> 
> I think you're on the right track, it was just that memory-hotplug
> setting that tripped you up. kdevops incorporates tests from multiple
> subsystems I would defer to Luis about more details there.
> 
>> I have seen the email thread "Usage of tools/testing/cxl" started by Raghu H, but that didn't seem
>> to answer his question (similar to mine), and instead pointed to run_qemu.sh. I've started to look
>> into this, of course having some difficulty. Perhaps a quick overview of pros/cons of:
>> tools/testing/cxl, kdevops, run_qemu.sh (and anything else that CXL developers use)?
>>
>> I greatly appreciate insight/help in this regard!
> 
> The CXL emulation in QEMU is the primary vehicle for integration
> testing. While cxl_test (tools/testing/cxl) is for regression testing
> the kernel-user ABI, and mocking up topologies that are out-of-scope for
> QEMU (like CXL 1.1 "RCH" topologies). The run_qemu project aims to
> automate setting up a VM environment that deploys the latest QEMU-CXL
> emulation as well as cxl_test. kdevops has aims to be an all
> encompassing test environment for multiple subsystems where cxl_test
> comes along for the ride.

ok, thanks for the above insight! I'll continue trying on these fronts.
eric
