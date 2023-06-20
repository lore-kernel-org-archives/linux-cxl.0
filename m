Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BE7EB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jun 2023 21:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjFTVQg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFTVQf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 17:16:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D33F4
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jun 2023 14:16:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KLAPNU001399;
        Tue, 20 Jun 2023 21:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zdqERwxIge/umFx4D8WHaRHtqbY+RKrqeQ8jjz7YktA=;
 b=VoVgd/HSKkU40TvUvpbhXx6/C+aVAV7rWt4NZfudAPooU5qb2L6fZ0OXTJAlcorJ7kBm
 /+Hx8/CXP4hqdSySflM1oHnH6XZ5wwbj8SiH3TCLKM1IFzg4ELxJQn2L/bJfcfU2lnEG
 XILnQUDANjMqAEVqzDFW0De+xC0ciV/jAgIxj0RCwzC0sCEPw7MjtS6YXGBW7a/GAKg0
 Wa43cZ/Obg4Xj59V5eqPgLofRTc+cIeiCxjngWxEa4fS+8gLDTgZzsWES+M668GIdtgC
 2WbZb3pM7NKw0z6j5nTAh8fyOYR6D9/hQ8M6rYy3ctOqotS5QTBrw4S/CtMXbLoffUaV ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3nx66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 21:16:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KKhT8C005988;
        Tue, 20 Jun 2023 21:16:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394xn3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 21:16:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSkqpgb4XZWavQMf4mCmPAAjCTHbCeaHd6yBcQV/LQhhsYP1L1OXggNg1EKx6GNkr6ddYu0oXORNICt9YUNdXixPBuKegS32pgP0WxdvedaMtlgQvy8JyF19Op9BCRjqyIFLWh8iorvxIzfMuQ9A53sZBde37n0t3/GDeDGtYfsTJQyNC1xvTDvX5qfI5FYLTNOzIkYodznZx+3RoOGEzAUC0d0wClBzxINsxs0AoWGJvBYiRZP1kt/UZB2ik6TD3FpUA6CENmmKvmDISGjUGWaIKeTIa8/WdwEGsatlbMMmYQ7fdwvos+XFqOK0Gdy11Cl54sWfFzIdLOcAMN2btQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdqERwxIge/umFx4D8WHaRHtqbY+RKrqeQ8jjz7YktA=;
 b=OxpyvRUJD8nO4XlXYyY9wR7bFc5vSbDPyreGaDhKrs+J1h6BA6PlhFisZK3A6y11o+V1t32/Zx6mFrhmerINTTvi02a+qO/WQP8o9GcHyj30pvz9xp8gxQiCnOdpWqgB3zTCDTr63nx4IKNLXW+Na+rskW9/+tXg16hC/ZW8Gt3rLrzQvuy+QDh6S+uu0ofCbWjORH/yHgYGkf1HstoJZM/cj7h2YCZqdSNq1GVw7Cq9o789VCjgNGX7U6ruH6XWdgYHD0MMgcgyPj8ayyHGRvqszPxeOJqGkpJksT1UrC7Yw/b989p5Ri+7UrLRBJsS7L1dcqFclx9NNatmWl/ZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdqERwxIge/umFx4D8WHaRHtqbY+RKrqeQ8jjz7YktA=;
 b=oAW2JMjeOgCRg7cA8kGp8PaUoYG4dFa4Scvwe7SgHmJ4xdDnGYKLaksf0x5Mg/UXeP68RfOvAisgdZS+1Kksu3VBTHu++sFS4Cr8udTt2yngD0donEsQdbpn75RIqqhoNYSS9AfZuFg3BnIWLp92RdGnv9m0ZS+KSb6qVcZ03Bk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH3PR10MB7561.namprd10.prod.outlook.com (2603:10b6:610:178::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 21:16:27 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 21:16:27 +0000
Message-ID: <dc35f834-784d-aee0-b51c-6a738262e432@oracle.com>
Date:   Tue, 20 Jun 2023 16:16:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Questions on getting started
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <544fdc40-0ff7-690a-d24c-3939d69c0725@oracle.com>
 <645572d181c93_1e6f29425@dwillia2-xfh.jf.intel.com.notmuch>
 <32e93bbf-a29d-148b-5f6c-859bcb2640a0@oracle.com>
In-Reply-To: <32e93bbf-a29d-148b-5f6c-859bcb2640a0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:8:56::10) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH3PR10MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 15497302-1b5f-4e7b-1e0a-08db71d39c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYeMkH5FGTIKDhqiP9u3EqlAn5hH+eKAytnxX76kb08AlZXqffZKfTjjsHncPNMuJmPLkD+4BciZ3S97OhaEqh3AcjzewE2T8CsJGA9smDTe/tP6dKtNAkJpb/ELSlSwE1pNUFqNTzTlBv7tNdWn59CThIuTnDk5mulRZIH3U2Qi6qfs55o81FQWbnI22NFdQPaIXVjx8MsbXVYihF0+446M61k6Sa/dlOmz7Rdd2E5LU2iUiNIQbI7U6hIoVbykMtlPfqxVU5s8xvSx+Dxy6OWtKd/qvLb21ateKh/rA1ef845BNLGkM0d6KvFlUHRLom7fxHsifH10mDgBYbIxZZLm/nyW42By61xSCn+2hX4RLcLvhx1gdwMZ2QmGD1X81LaYfh0nGTq4aZXqPcD8CtXq0zP6P/HMEEfG+WSPPpoPZm7E4mLJe3Tyzz8AA/qXq6P1Gt22mvBHVspmFJC+tnvVArad1bRrTYFMrd5Vs7M3QbQJ2iYeMRQySsBdMuSOzE9M/82/PVi48YDv/d+YhObb/M64X8bBKvWgz+KSxxzXo8x4ln3cpxIAh90z0/UCAEsW6caTXHT5C+yIfaK2BjVha/zpvS74b2nsyWvdnhjRLU44SH+SGQbXd7quYEQXX8Bk9KWA6SnqaUyQCWnn6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(2906002)(478600001)(5660300002)(66556008)(41300700001)(66476007)(316002)(31686004)(66946007)(186003)(6486002)(8676002)(8936002)(53546011)(6506007)(6512007)(26005)(83380400001)(2616005)(3480700007)(66899021)(38100700002)(31696002)(86362001)(36756003)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ByYnoxeUJxU0FEVXoydmw1MzRucVNjRDVrVEs0MVIvUWdxYjN3aHpPNWdF?=
 =?utf-8?B?Mk1EaDdDeHNhYUNacnBtam9TMk9ONXRaOStBR2tDQk10Snc2T1pyc3BmeHMw?=
 =?utf-8?B?bUJ4YnBSUlZRY215NUx5dEZCWGh2RWpWRk4ySmhDUEZyQkpValF0Qmw5akJM?=
 =?utf-8?B?QnBmSmpKZmFySkg5dXYwUWFWbDQzUGl3WmhwOXpnVUp5Z2lSMWN0T2ZEUHZi?=
 =?utf-8?B?SzJsRldOT2tRK2FjT2sxdjdOWGd4cGtURk5MNDZLV3N6bEwyamwxajFvVGQ2?=
 =?utf-8?B?S2tHRmFVekdFQ3ZsL3pubmpXMWF3N1BFUU5pOTZRRTVFZnlJZEZnYkJBUnRG?=
 =?utf-8?B?Y0RVcVZ3RUtkU3ZwVHdES1g4OWdhQVdYaC9JVWd6c21YWVlMWjVGL3NNR0hH?=
 =?utf-8?B?dHcvL2FaT0FHRDRlWTFLQlFWNE8xbnRtc3NIby95UldVaG5keHNCaWlVWnFM?=
 =?utf-8?B?czY1bWoxMXh5ekhCdjlHRGltREJ1NFVBSm9ra1JDdlRYbmxhQzVwTm11Qkp5?=
 =?utf-8?B?bG9wY1A0Q1Iza25sRDFVY1JRZ2pESG9WK29hNUhaOU9wV2w1aDBNcytsaHVL?=
 =?utf-8?B?dmxkcCtxbTB5MFpMcndVVDdkMGw1bmwvNVNaZ3BCeUdTcmU3dHhuV2kvcm5S?=
 =?utf-8?B?akFhVUpCK21SVC83KzE5M2VZcG04Tm1EbDZRdlhkU0djdWlRRVcrdnJ2U29Q?=
 =?utf-8?B?OHNydGc2QmwxY2l0MFlkczVJNzJoV1pVYTZoTTFhL3FBaW5icEZrVXZENk9H?=
 =?utf-8?B?UFhuS0wySjBib2xEeXkvQjc2U1FSMm1VU0xEUlBwV1l6SnZYZytJSzlmVzVn?=
 =?utf-8?B?aXJkWE9EM1RhenRoU3Z1UHRwbTZZMEUwT0hYUXdTelBDbVpZSXBNci9qL000?=
 =?utf-8?B?QlpiS1l3Q1lsL0tkU1dHNkRxcDNTd2tTVXh1UkNSSFlSWkNoWVNFaVYwMjlQ?=
 =?utf-8?B?Y0cyQkhKc3E2VHZPQncva0JvOUxNOFF5VEIvY2l0UndVRWhWYVJnWjByVitE?=
 =?utf-8?B?R3MydU5WV3BmaEVXQnNSclpqQTVyRGxadDlOVDlUbjBQVnYybDkyWmw4WktX?=
 =?utf-8?B?U25KZDZySnErVjBiS3V6cFdlUzFnMFZqN0RkQncwWUJrcEw4M3U1b2JXcU81?=
 =?utf-8?B?MXg4UXZuUHM5V25mdWFIUjlBR1gwZEtuTW9lS1Y4dG54aFZjY0VkblgrRlVk?=
 =?utf-8?B?TEV4YjNHekRXWkQ4UmxFc29lNWJLSUR5eE9IU2JiaXlud2c1S09kanRhYXYv?=
 =?utf-8?B?WmdRTUxSRjFocDV4OWEwMkFKZThQODVBeUtKTGFWb2c1aE5xTzhWVWJWWE5P?=
 =?utf-8?B?NlZqSGdYUURlY0xNa0JpNThYVXBISWtVV2RhVFVsZHVxZjFuUURrZjdrTnU3?=
 =?utf-8?B?MlZOSU9wNnh1UDBEZkdhRzhDd1A1a1ZUKzRpY2xKeEVZQ3lrNWRIVzlOejcx?=
 =?utf-8?B?SWIxQWswdmd6QSt2YkRCSVJ5Q1ZyWVdJWWRKUW5HcGNuWGtyaXhVQUJaRit2?=
 =?utf-8?B?UUJmb016TUc4bTJSOUsyeGVUQlNKM2s4YWQvWHp0dEVSMExGRElhbWVXVFU4?=
 =?utf-8?B?Qzc0NFVsVitUcGJNUWdIYUFRbGNHTy9IQ0lyblVteWhCeVgzcmc3dCtRVFNq?=
 =?utf-8?B?c0RwaHovbmZnKzBtaEZ4dzJMVWEwc0htY2NaU3RlMmcxM2dZZjNLMFYxMTY3?=
 =?utf-8?B?enRSVEZRUmVScXRLVG9HcXhzYUF1WkY1a3hXTUVGYm40T0YvS3BIOFdnOHkr?=
 =?utf-8?B?UjVwOVU1c2VtdWVBZ0Y3dHdMYVhFbUFoTWxqVW1LZmFXdEVKM2RpYnFhcDM5?=
 =?utf-8?B?NWE0WVBjZW9lMG5GRTU0TTR6QmFZdzRNdTExay8yRnZ5VTJzaVNiUWlnNFBW?=
 =?utf-8?B?T05Wakc0elcvNHZJTVVCb252OVBSTnRVZUdoTzhVdzVLY0J3cWYrSjBzTVJJ?=
 =?utf-8?B?YW01VW5IQUFJUkJGdzRHNGNjL3NYU3U1dVNlTjFIeDZYWC9TbzYwQUJPamlZ?=
 =?utf-8?B?MEtaeTJGZk9Wd0ZTLzloTVVNYzBvSFBxMmxDMEZpYXQwM213clhuSExIN2dE?=
 =?utf-8?B?Mlp2N2J3MDdoSkV1dUFzQWR5ZDhkZkpmc1ltcmxzSTFlaHRBS1FweFcrNmxm?=
 =?utf-8?B?bE9PckF0SHNsWU55bFd1Wi9saTdmUHRzdEpuVTZSK0g0OFZ3NFlsNXlSMUNJ?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aB3RLE5yD6pj/SPcq6dAqVO8doVBIOMms0HWQRBx8EgVQq5wtkgiap5lvZH8CbiH5UZaOEt3xacRJigI/L1XlAujsfGyk3HKaMju3KtPyksuHphLqFxfvqMtrHUTSne6okmFhM7Zw7o9yFzKtvJ7KSH1Fvz/nBEwasFPcEIKaH6WzLQCYX2DerRSnMZiaOsVvSnjFmScShaYMVWq7m7ILszyyClVDmQWhe+usMXSkW9TBzny7AmQ3EvE1fSx8vk4h8OAqSwxipfq3+G7K9JY/tlmnOOlgXwzh3DJVDxwuzBfJNIEi5EmknORR+dGadWC0nDBDrTC01qB6wWUfjKzZ/DhVC19+iyf9Ze/vqYpZwoB+o2ZrgOof0rF3gIts1eXJj1zH+erCQmxVEnsONSZwP8Bi4RwLsdCCRZXEpvy2DE8cP/1qkT3iM4cqwXsLxqn5934S3iKuCTrO4o74rOh5ll1A76uz7zApi7s1QE9vwEyuKgrGbGZpC0QNhzO5GNpxAuZu+vb7ptNz0AvoTqWrreotrOK1xNk6IwQ85H+r5ezSoxggQjXRxQA1EXC1Xca4xAet8KlhEo6lIpGQc9giuVMpT6kF8OnJBuJCTDYlXvTqyoZZyjB/iVUsA2FpyQR+CZBfyBSYJzWguBdZArN4SQKn5xshrJugI2FZc8RKA6RmF7wmuWBOEhb5A3oNiLvTsvrAFeveJVtMkwcQ31l+MXj4LCsHvNsDzmHa1EwGj9XgbFtfYlN95p+j/5d2oerx5tdAJzsqWo3EoP0LxEN4SS8/+zmaJD6opCnIa8mxzk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15497302-1b5f-4e7b-1e0a-08db71d39c3d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 21:16:27.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQAUXlTtnnc4RM7a1NwoCb/NdGZDqOdRXNVkuxSMI8+ENRefW7YNGpZ8pkUvdsXQNlylc806X47VrYqUYd+9/T84BMlUtfxBY4x81ZjgIfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_16,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200192
X-Proofpoint-GUID: j-HjPNV60NfXck4ywkLfdh1-TL-SKJhQ
X-Proofpoint-ORIG-GUID: j-HjPNV60NfXck4ywkLfdh1-TL-SKJhQ
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/8/23 12:21, Eric DeVolder wrote:
> 
> 
> On 5/5/23 16:19, Dan Williams wrote:
>> Eric DeVolder wrote:
>>> Hi,
>>> I'm new to CXL
>>
>> Welcome!
> 
> Dan, thank you! I'm keen to make forward progress with CXL!
> 
>>
>>> and have spent time browsing linux-cxl traffic to get an idea of where to start. I
>>> thought that running the tools/testing/cxl was a good place, seeing as I don't yet have any hardware
>>> on hand.
>>>
>>> Through various nuggets within the linux-cxl messages, I landed on the following:
>>>
>>>    https://docs.pmem.io/ndctl-user-guide/installing-ndctl/installing-ndctl-from-source-on-linux
>>>
>>> Following the instructions within, I was able to observe the running of the CXL related tests.
>>>
>>>
>> [..]
>>> 6/6 ndctl:cxl / cxl-security.sh             SKIP             0.03s   exit statu7
>>
>> This skip is intermittent and should be fixed as of:
>>
>> https://github.com/pmem/ndctl/commit/82a0cda5
>>
>> ...were you running with that?
> 
> Yes, I'm on ndctl v77, and verified this commit is present in my build of v77.
> 
>>
>> [..]
>>> OK! Now, if I repeat the above steps, but with recently tagged 6.3
>>> (perhaps thinking it would yield a passing suite):
>>>
>> [..]
>>> at which point I've lost the system and I have to reset it.
>>>
>>> I suspect the faults in udevd have something to do with "plugging" in memory, but I don't have any
>>> ability to inspect after this point.
>>
>> Yes, good insight. I have this setting locally, but the instructions
>> need updating that as of commit:
>>
>> e9ee9fe3a9d4 ("dax: Assign RAM regions to memory-hotplug by default")
>>
>> ...the test requires booting the kernel with:
>>
>> memhp_default_state=offline
>>
>> ...or building the kernel with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n
>>
>>> It appears to go boom when attempting the first test in the suite, cxl-topology.sh.
>>
>> This is because v6.3 adds a preconfigured ram-region. The test validates
>> that the region is auto-assembled and ready to be onlined. Given there
>> is no actual physical memory behind the fake address ranges used by
>> cxl_test that final "online" step that would happen on real hardware
>> needs to be skipped.
> 
> Makes sense. I've confirmed the commit is in my v6.3. However, I still observe the same/similar fail 
> with memhp_default_state=offline (and I've changed the .config to 
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n as well):
> 
> [root@localhost ~]# cat /proc/cmdline
> BOOT_IMAGE=(hd0,msdos1)/vmlinuz-6.3.0 root=/dev/mapper/ol-root ro crashkernel=1G-64G:448M,64G-:512M 
> rd.lvm.lv=ol/root console=ttyS0 memhp_default_state=offline
> [root@localhost ~]# cd linux
> [root@localhost linux]# git branch --contains e9ee9fe3a9d4
>    wip
>    wip2
> * wip_v6.3
> 
> It still fails in systemd-udevd which suggests that the hotplug online events are still being issued?
> 
> I've tried linux.git tag v6.3 (the wip_v6.3 branch above) and cxl.git#next (shows as v6.3.0-rc6) and 
> both behave the same for me.
> 
> I must have some other config item at play.

Fwiw, I found a workaround that involves short-circuiting the udev rule that onlines hotplug memory 
(/usr/lib/udev/rules.d/40-redhat.rules in my case). By having this rule NOT online the memory, the 
tests complete. Which validates my assertion that the events were still occuring despite 
memhp_default_state=offline. I didn't root cause this, but wanted to share there is another way.

Thanks,
eric


>>
>>> So some basic questions:
>>>
>>> - Should the above sequence work with upstream kernel?
>>
>> Yes, and with memhp_default_state=offline and ndctl v77 I get:
>>
>> 1/6 ndctl:cxl / cxl-topology.sh             OK              11.90s
>> 2/6 ndctl:cxl / cxl-region-sysfs.sh         OK               7.32s
>> 3/6 ndctl:cxl / cxl-labels.sh               OK              10.58s
>> 4/6 ndctl:cxl / cxl-create-region.sh        OK              18.40s
>> 5/6 ndctl:cxl / cxl-xor-region.sh           OK               4.76s
>> 6/6 ndctl:cxl / cxl-security.sh             OK               4.23s
>>
>> Ok:                 6
>> Expected Fail:      0
>> Fail:               0
>> Unexpected Pass:    0
>> Skipped:            0
>> Timeout:            0
>>
>>
> OK, great! I looking forward to reaching this milestone!
> 
>>> - Having noticed that the nvdimm.git kernel went dark, I thus tried the upstream kernel. However,
>>> from the mailing list I learned about https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git.
>>
>> Yeah nvdimm.git is only for dax and nvdimm maintenance. The branch you
>> want to track for updates going into the next merge window is
>> cxl.git#next.
>>
> ok
> 
>>> I have tried the same sequence with this kernel and a various few branches/tags. No luck. Is there a
>>> branch/tag here for which this sequence should work?
>>> - As these tests utilize a mock driver to emulate various cxl component(s?), I have found that there
>>> is no need to run this on a system with CXL components (ie real hardware of qemu), correct?
>>
>> Correct.
>>
> ok
> 
>>> - Is there other documentation for learning how to run CXL tests other than this pmem.io ndctl 
>>> write-up?
>>
>> There is some automation for setting up a VM to run the tests in the
>> run_qemu project. That builds a kernel and root-file-system and boots
>> with a canned config that is expected to work:
>>
>> https://github.com/pmem/run_qemu
>>
>> I tend to run a custom VM and give feedback to the run_qemu project as
>> needed.
>>
>>> - Is there a better/preferred way of running tests beyond this? I've seen reference to kdevops, but
>>> am equally confused as to what it can do (in part because it appears to use the above mock modules).
>>
>> I think you're on the right track, it was just that memory-hotplug
>> setting that tripped you up. kdevops incorporates tests from multiple
>> subsystems I would defer to Luis about more details there.
>>
>>> I have seen the email thread "Usage of tools/testing/cxl" started by Raghu H, but that didn't seem
>>> to answer his question (similar to mine), and instead pointed to run_qemu.sh. I've started to look
>>> into this, of course having some difficulty. Perhaps a quick overview of pros/cons of:
>>> tools/testing/cxl, kdevops, run_qemu.sh (and anything else that CXL developers use)?
>>>
>>> I greatly appreciate insight/help in this regard!
>>
>> The CXL emulation in QEMU is the primary vehicle for integration
>> testing. While cxl_test (tools/testing/cxl) is for regression testing
>> the kernel-user ABI, and mocking up topologies that are out-of-scope for
>> QEMU (like CXL 1.1 "RCH" topologies). The run_qemu project aims to
>> automate setting up a VM environment that deploys the latest QEMU-CXL
>> emulation as well as cxl_test. kdevops has aims to be an all
>> encompassing test environment for multiple subsystems where cxl_test
>> comes along for the ride.
> 
> ok, thanks for the above insight! I'll continue trying on these fronts.
> eric
