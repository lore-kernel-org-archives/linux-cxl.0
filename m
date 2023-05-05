Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66898C77B7D
	for <linux-cxl@archiver.kernel.org>; Fri,  5 May 2023 20:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjEEUfG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 16:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjEEUe7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 16:34:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA1749EE
        for <linux-cxl@vger.kernel.org>; Fri,  5 May 2023 13:34:50 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhN5P031597
        for <linux-cxl@vger.kernel.org>; Fri, 5 May 2023 20:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : to : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=mZ9/eThwyPOXlaipt+qZGqoJFGm6G2HqxyRTnLesy6E=;
 b=smUB5vld9s/BFr/Gm1RlJ4V/6j0fI16mkKpA7a27udnJdzdCBCg4JmRYBsn8BeFvlNaI
 OUk2cqYbE4WabRJrk9i7ePt+bPmurzY1OQqmz254EMDC8vpxbNYr7Z71hFWGRMLlUzIb
 UfiRgWV8rPfYDwp9dkalQMn/YaKgnQFBTJmU4z1xVC8HLsIA8bCcw6swAXZ2x5rNc+XQ
 oxAFrQPFKwMx2v+tlXQRQKIqR6+lweWhE3x6nuDjd8Sj4NSn5I+7mhiaWdlkKqCi/yy9
 8Xdb5nIPqO9oiFa5QjhDawGg7AjJB/EbDPZV0GVDUTUKdmQqzNi2qjaZHJk1PGd7Tv27 kw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d5y19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-cxl@vger.kernel.org>; Fri, 05 May 2023 20:34:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345JkA1X024982
        for <linux-cxl@vger.kernel.org>; Fri, 5 May 2023 20:34:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spahx6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-cxl@vger.kernel.org>; Fri, 05 May 2023 20:34:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw5r0w0vawrpKgGnWJfRxpLkL6XQ2Fp+WhKUgeZeT6kJCYEmvZ/0AuSKeQ1BUpU3TTnFetZhwN4S2lYI00G1IHnAPWDh4fzx8yjK7bPwtI5aqsM+nQDHfAFktKPiP4aaWAnAzXT/CzN4IR3Lu1dEEwZhI/IFdW71EGhFYWvQqKZ/YMnozI+V4mkLMOtOA5jtvVF5+LNWl/zGXbyKMN/suvlQAfhh1+QdcMzQraP49LcWPr+o8neqdkof9uVAOBkAJCwxRj1rK+IW/Y4/Ta45i3LVu0jiJz8LsmBON1QRgAWuZB9w6k/bErBQE8WN7KivNGgo4EAnQvjB44gMW+xOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ9/eThwyPOXlaipt+qZGqoJFGm6G2HqxyRTnLesy6E=;
 b=oD3MwanuUPD7hLLehZe/2R2dco5s9z3m6lyNcrsTd8rb43eXKOgkvqngO7V1HTi3x6E6q/+MKopMbhjdcBMPaU5/ciMhBnluvFP6UzC9CSUK0q6/0ScT294v/5E3gxRhk0EBRMsHsIzAUAjqcrdsLjCYQ4z0ezGHske0WTd3yhmWq203YvimddAdAPDU2QWLrk9Y3s9v61CHFftxcEcF70hWw67rS1QQUeew8d8cE8dj/qjqCnjiTaNqQT1vwlNl4ItunghP30PhNG9pfDRg25Hk913sB1Q7IBd8f4pEVZXkrX48f0xi0EEahXXco6/DULQYKfquwRlMaHiZ2Z8EoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ9/eThwyPOXlaipt+qZGqoJFGm6G2HqxyRTnLesy6E=;
 b=mR7+NnG3QkW3b8LLJFTrxTAbWBLwujD/JJCAs6YTBN80RNoCX0AaPFYcgQausYYA0nXw841qFWX6QYOeMjOJWZGLXHVqlNGr9tkAjUWfHpo1vsDlN5TnkaYgkrtERu6p77qz45/s4VyClqRclFyuITv8r4lKasQiAteeGdsX3bo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 20:34:46 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 20:34:46 +0000
Message-ID: <544fdc40-0ff7-690a-d24c-3939d69c0725@oracle.com>
Date:   Fri, 5 May 2023 15:34:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-cxl@vger.kernel.org
Subject: Questions on getting started
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: ad347302-461e-4641-0c77-08db4da82a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Em2JQ6c2dbv1ds0zMlUH2H67//P0YpGqYeG5Fd6e1mrRDvEoiZjMdh24+6hr+XFqOw0Y86iYK2F/rrDAlYN8oT8uyfycXuJq3x51eQVMeC0EbRG9gfa+71PNhZzY/k0NuuOib69gBWPhf7frTh79gLukzS9/reiLTHq2MX1uDNVd84MxlWfpw/EmxJLaUXCGxjbQg0ABNSGmUz06/aUNZIKjKA9oKTAD+Ju7tc13W3hFj/ayqaAtewzCJSIACKT0jTnhHbiC6vQwmHevhqUHZxVRGAv99VNCUcPmlSmp9QTCvFaVelB/GrKpuZGdiNVl7N+4bLQx/GusVlE556Cn+j8V1lbC2ipnD8sdUj/CO0SkNO2Z1FQqSbVBo3hTw2krOmUZuLcgIOAd1CT3yF1ZaocJSVH25bODj4Mdhyk2fLt/YV9lClo72+6n4Ai0aBoqpAUoEdf+XC678UZjaRIGS+FkQ7SO4YxnGtYaluL+IKTdb8WownnCzVcwMP4KPnvNXqSut34Mbgn61YtfLvmxHdlbZdMmnm3HW6s08RQPfuvFiCm8P54vuf2YlxgErxPJVdnQVmI/mRjsFLyL4LMARst7xOo3DTZa0MyuEVbf/WXQs6uzpsJBheBXCFp2ddn1H8nL2zi0G0kM4rv/m8SfBdhBbfPxvrxLmB7N9AK3AzDViJ95qPPKXpaS1+MBmIZF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(31686004)(966005)(66476007)(6916009)(66946007)(66556008)(6486002)(6666004)(478600001)(316002)(86362001)(31696002)(36756003)(83380400001)(2616005)(6512007)(6506007)(26005)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002)(3480700007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akp3WitxTysxWnovZndmRkVEMVpGYU9KeXEvVXJsSW5FRTRWNWcrRy9OTE5a?=
 =?utf-8?B?Sm1WdkFHV0U0ZVJxK0V4K3AvZFJabW5ndk1RTHJzWkh0MGJCRUNRaUthdXk2?=
 =?utf-8?B?QUovdTZhd21udnowdEpMSGIzblN4RWF2bGVOcHkrU3kxdDk2YUswZ1NmNDhG?=
 =?utf-8?B?RTFDNzhMRnZYcDNGZTlldjcwc29BT1YzWFA5SFJDamxkUFRQejZsbDRWVVpL?=
 =?utf-8?B?bXRsOWlycWlkU3RNL2pVRVdBaUxTdWkzRkR5bmtyT3BIL2J5WHN4R3F5WDky?=
 =?utf-8?B?WXlPRUh3aDRUOTNzckxiV1FqWVRPYURwUmpScUh2RXU3NVluaDlEejhSbG9V?=
 =?utf-8?B?eTlhS2tIcll5NmxyMkVOWTFncHU0MTduVVgwb2FaVm9UcWxvUi9ZbUJ1U1Bj?=
 =?utf-8?B?aFJrRWVsYzcxYmppamMzcWtmNGF3TlRkdXp2QS9DTzg3MDZnd1RmaUptQ3JQ?=
 =?utf-8?B?VVA1alVsQmJscnI2a05tcEFWQUpFNkxrZHRPZjRuRUJZNFhsZ0xYMW1SZEF4?=
 =?utf-8?B?NjBpUGZxMUowWGVVYUhXN2tZUVdHQmdHQVVuRGJuMDhPY2tUelBaOFlkVnI4?=
 =?utf-8?B?eW90Y2VzTFA4eHJnR25NRFBqbzJwcThjVGI1Y0dhZjlQNmRaK1RWMDROdEVh?=
 =?utf-8?B?Y3MrT1lyNGVhcU5mVnZ6cGppWFcraUFzdmg1cHJYSzI5QWdYSTBsb0pQb3hv?=
 =?utf-8?B?VkNtZTFHVDl4UUUwdFk4SW5JT3ZRZlZIMHkvcVM2SnFNUHFIdjU2bC8zbXdB?=
 =?utf-8?B?NjRHbWJTdUVTOVBIM09ubjB1NjVzdnNuM2hIbW4wNGFLb0crUXRXZTRzYXpa?=
 =?utf-8?B?WDZNdWlRd2ZkblhZd28rcEovM0dqUWRiT05lVHJkTkcvUXVuaGROaEx1Tzhs?=
 =?utf-8?B?aFU3NmVWUVpXVmdXSXdCRCtxZitNVWtsNUVHS1ozdEQyTzFxRWNYaG4xRkxj?=
 =?utf-8?B?UzVYU091OVdhMGlSdDdyMjdmK2xBdTk4YXZwVFY2S011bGNmdWcwbWdIcStW?=
 =?utf-8?B?N3UrNFIyWUwwK0U4cXVJemxmbFhMbERFQ0ZWTGNzY2UwQ0ZvaWMyZytPd2c1?=
 =?utf-8?B?N0ltZWsvbmptdlgrRkFuWVR4cXQraTI0OUpDMXpndmpOcjIwMGI0L1RUbVk0?=
 =?utf-8?B?WUFocmxiTjRMQk03UTJXc0RWcjg4Y2NYZEZ1RzVQM0o3WUg2SXBOVGhubDha?=
 =?utf-8?B?ZnB2Um5TSGlQSVQralF5TzVQdkVTVkErWGViQkJHS1U4cnBNRGxNZ0Z6b0lp?=
 =?utf-8?B?UzBUdGhQNlNHRU1udG1oN3ovM0hQWlpUeHcxV0U1TEdTMnkwNFFJL1V0RVFP?=
 =?utf-8?B?RnR3M1kxV1hKS0RyTU9KTVZvLzhoUEZ5ZlNFeVZiSVNkT1hka3BhcThlT0tD?=
 =?utf-8?B?Q3BTc2tiMkdvRkRXbm5UelZXME5vVWxnUmxScHVZK0lQZk00bXJieDRDS3BK?=
 =?utf-8?B?M1JqalJyTHNGUzFnTHRxRlVCcGljMys0eExTUDJLQUtvKytFTUQ5NklDTGFk?=
 =?utf-8?B?c0ZMaWtnYkRCbjljTHErdzd0WmM5WTY1dGthMHliRWg0M3hMY2c1cnl4YzJZ?=
 =?utf-8?B?RU43NTlXL3lGdkxsYkdldDFzQ082TmtCaG1NcEg1OVhVYitndXJHN1BiSkta?=
 =?utf-8?B?RnBpbGpWV1BRVHRQbCtWTWQ5Sms0QUV3NWg3bEJnVGF6U2YvQzltNFc0c1lp?=
 =?utf-8?B?a3hsd3BxZHFJS01wTi9XQU56OHliSEd6WXdMemRUZ0FZOWhBQnhVOXhkOTBq?=
 =?utf-8?B?Y25CU0RMQ0Z6YXFoNmVzMkFDMGJUZ2hBU29mV005MkJOYit4eTJLR3E5dHRj?=
 =?utf-8?B?bnBFc0RIa3NSZTZsTncvQkk1VG1QNFV5Q3E0R3ZpRFBEcTV1endyZ3ZVYVl0?=
 =?utf-8?B?SzhPVUJFYWxvZ1ljR2l0QitXcjBZVCtQbC9SN0NMM0pWL0VJVERxRkxKdW1u?=
 =?utf-8?B?Nk5HTWNtWE9Xc3RDVHFOK3d6U0VVVzRmNkRLMldGVkhyQlV6citkTHdHam5j?=
 =?utf-8?B?bmdJNFVGNXpmKzk3cGZIUnNpMkViQ1lXMFpVQTl4VUw0cllsQm9nRG9mYUty?=
 =?utf-8?B?ZWEvaGYzYXZCeUlKRlJ5UG1tQzJtTVBhRkFrcU9Nb1B5VzFvNkVVeVlUbTkr?=
 =?utf-8?B?MHRKcHNJaVc0TG1MOHdTV2VuMi9wZ21WN1FqY3kwRGxwekV3VFFOT1pDMEk2?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eFanBUEMLqOAQViC6U7E48Jzs215nNLLaLHauV/pW2yxUriTWPC7jX88nxz4ffuOZa6DCyV3aZS3z3hz5WsFzapFrOURHCm9I1WTZBubLj2Dm4cWmP6sf/5DVHiI+IVuEor9jmyS9XDCk7lkeCJc04GXBCA47418pl1tQylojaYiHGjVaAM5P4SX2J5+kCI7PdpVK2fZEiOAF++Z790lyFU6FdHQqueq18XRiFZ4h531PU+pHizVX6vqm/wsAG9A1IpblVUtoRIxAD3rIl4LUcro1ZJsRIlFF2mix+eFvZbfrv+fDKFgw7gosDy89bcwIreVUz7abH7rYI8KT2pIKGsN2AA45CA0A1Ol04wXqygegMmsaKGGxMYR6n1wSVPmoiDq3lDLOH2GqG7Ve0AET0Lr/cm3geRudd4tpYspICU4gOdu/AUe09SDsDYrKoaBTNiQ3XvAy4U/2vidtCZNhJ9teUsLvyBVUisbSQbfdZyyEiZYNoPpANqmtq6wsU7cOOyCnNFMKy6LAA1T1Kw5sZFN5NFChOOXclevMTS79V0IKkLXj4zz6ws9YOU9vBZNS64ksJz8aWZXNRHt4TUzVAqLuepQyMkrcXc+J8kBroCLIEkYeC7OcHE7wlE0LP3dXWRy44ZBXa7UKft6OWci27/kFwoATiSU4bbhHRCfFL8g3dd/KQ1AtXBWo/hwkE4VNejzhlvtVyJpFiGefS3vqHufOSS0Ei2WcCik3dRlt5dSOBUgKoMpLT1o2zgZXRy7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad347302-461e-4641-0c77-08db4da82a2e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 20:34:46.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0BfTsm0GkN4P9QQ9wZgK9u2eFXE6FfyNFdVJUsl5Z2GCrN2Ft+Udn8Vwr4tMhW/TNYfAcyXKKpGwb9DlrjVnlY7y4rc/au96ximNNFTdq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_27,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050167
X-Proofpoint-GUID: G7d2vvC-UpkCJjjmT2PWs8AVlykSC9ff
X-Proofpoint-ORIG-GUID: G7d2vvC-UpkCJjjmT2PWs8AVlykSC9ff
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi,
I'm new to CXL and have spent time browsing linux-cxl traffic to get an idea of where to start. I 
thought that running the tools/testing/cxl was a good place, seeing as I don't yet have any hardware 
on hand.

Through various nuggets within the linux-cxl messages, I landed on the following:

  https://docs.pmem.io/ndctl-user-guide/installing-ndctl/installing-ndctl-from-source-on-linux

Following the instructions within, I was able to observe the running of the CXL related tests.

git clone https://github.com/pmem/ndctl
cd ndctl
rm -fr build
meson setup build \
  -Dlibtracevent=disabled \
  -Dlibtracefs=disabled \
  -Dtest=enabled
meson compile -C build

git clone -b libnvdimm-for-next git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
cd nvdimm
make oldconfig
make -j32
make -j8 INSTALL_MOD_STRIP=1 modules_install install
make M=tools/testing/nvdimm
make M=tools/testing/nvdimm modules_install INSTALL_MOD_DIR=updates
make M=tools/testing/cxl
make M=tools/testing/cxl modules_install INSTALL_MOD_DIR=updates
make -j8 INSTALL_MOD_STRIP=1 modules_install

reboot into this kernel 6.0.0-rc6

cd ndctl
meson test -C build --suite cxl
[root@localhost ndctl]# meson test -C build --suite cxl
ninja: Entering directory `/root/ndctl/build'
[1/51] Generating version.h with a custom command
[   44.899562] cxl_core: loading out-of-tree module taints kernel.s
[   44.901116] cxl_core: loading test module taints kernel.
1/6 ndctl:cxl / cxl-topology.sh             OK               4.78s
[   49.668891] cxl_mem mem0: at cxl_root_port.0 no parent for dport: platform
[   49.672223] cxl_mem mem1: at cxl_root_port.1 no parent for dport: platform
[   49.674894] cxl_mem mem2: at cxl_root_port.2 no parent for dport: platform
[   49.676408] cxl_mem mem3: at cxl_root_port.3 no parent for dport: platform
[   49.678195] cxl_mem mem4: at cxl_root_port.0 no parent for dport: platform
[   49.679867] cxl_mem mem5: at cxl_root_port.1 no parent for dport: platform
[   49.681792] cxl_mem mem6: at cxl_root_port.2 no parent for dport: platform
[   49.684221] cxl_mem mem7: at cxl_root_port.3 no parent for dport: platform
2/6 ndctl:cxl / cxl-region-sysfs.sh         OK               3.67s
[   53.342170] cxl_mem mem0: at cxl_root_port.0 no parent for dport: platform
[   53.344181] cxl_mem mem1: at cxl_root_port.1 no parent for dport: platform
[   53.347003] cxl_mem mem2: at cxl_root_port.2 no parent for dport: platform
[   53.349285] cxl_mem mem3: at cxl_root_port.3 no parent for dport: platform
[   53.351029] cxl_mem mem4: at cxl_root_port.0 no parent for dport: platform
[   53.353070] cxl_mem mem5: at cxl_root_port.1 no parent for dport: platform
[   53.361240] cxl_mem mem6: at cxl_root_port.2 no parent for dport: platform
[   53.363233] cxl_mem mem7: at cxl_root_port.3 no parent for dport: platform
3/6 ndctl:cxl / cxl-labels.sh               OK               1.74s
[   55.081505] cxl_mem mem0: at cxl_root_port.0 no parent for dport: platform
[   55.088292] cxl_mem mem1: at cxl_root_port.1 no parent for dport: platform
[   55.090247] cxl_mem mem2: at cxl_root_port.2 no parent for dport: platform
[   55.092098] cxl_mem mem3: at cxl_root_port.3 no parent for dport: platform
[   55.094250] cxl_mem mem4: at cxl_root_port.0 no parent for dport: platform
[   55.096137] cxl_mem mem5: at cxl_root_port.1 no parent for dport: platform
[   55.098096] cxl_mem mem6: at cxl_root_port.2 no parent for dport: platform
[   55.101479] cxl_mem mem7: at cxl_root_port.3 no parent for dport: platform
4/6 ndctl:cxl / cxl-create-region.sh        OK               3.79s
[   58.868068] cxl_test: unknown parameter 'interleave_arithmetic' ignored
[   58.870435] cxl_mem mem1: at cxl_root_port.0 no parent for dport: platform
[   58.872472] cxl_mem mem3: at cxl_root_port.1 no parent for dport: platform
[   58.874508] cxl_mem mem5: at cxl_root_port.2 no parent for dport: platform
[   58.876442] cxl_mem mem7: at cxl_root_port.3 no parent for dport: platform
[   58.878542] cxl_mem mem8: at cxl_root_port.0 no parent for dport: platform
[5/6] 🌓 nd[   58.880934] cxl_mem mem9: at cxl_root_port.1 no parent for dport:m
ctl:cxl / cxl-xo[   58.883167] cxl_mem mem10: at cxl_root_port.2 no parent for m
r-region.sh     [   58.885336] cxl_mem mem11: at cxl_root_port.3 no parent for m
5/6 ndctl:cxl / cxl-xor-region.sh           FAIL             1.07s   exit statu1
 >>> NDCTL=/root/ndctl/build/ndctl/ndctl DAXCTL=/root/ndctl/build/daxctl/daxctl h

6/6 ndctl:cxl / cxl-security.sh             SKIP             0.03s   exit statu7


Ok:                 4
Expected Fail:      0
Fail:               1
Unexpected Pass:    0
Skipped:            1
Timeout:            0

Full log written to /root/ndctl/build/meson-logs/testlog.txt


OK! Now, if I repeat the above steps, but with recently tagged 6.3
(perhaps thinking it would yield a passing suite):

[root@localhost linux]# grep NVDIMM .config
CONFIG_LIBNVDIMM=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_NVDIMM_TEST_BUILD=m
CONFIG_NVDIMM_SECURITY_TEST=y

[root@localhost linux]# grep CXL .config
CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_ACPI=m
CONFIG_CXL_PMEM=m
CONFIG_CXL_MEM=m
CONFIG_CXL_PORT=m
CONFIG_CXL_SUSPEND=y
CONFIG_CXL_REGION=y
CONFIG_CXL_REGION_INVALIDATION_TEST=y
CONFIG_DEV_DAX_CXL=m

make oldconfig
make -j32
make -j8 INSTALL_MOD_STRIP=1 modules_install install
make M=tools/testing/nvdimm
make M=tools/testing/nvdimm modules_install INSTALL_MOD_DIR=updates
make M=tools/testing/cxl
make M=tools/testing/cxl modules_install INSTALL_MOD_DIR=updates
make -j8 INSTALL_MOD_STRIP=1 modules_install

reboot into this kernel 6.3.0

cd ndctl
meson test -C build --suite cxl
[root@localhost ndctl]# meson test -C build --suite cxl
ninja: Entering directory `/root/ndctl/build'
[1/51] Generating version.h with a custom command
[   43.760734] cxl_core: loading out-of-tree module taints kernel.s
[   43.763128] cxl_core: loading test module taints kernel.
[   43.842714] platform cxl_host_bridge.0: host supports CXL
[   43.844520] platform cxl_host_bridge.1: host supports CXL
[   43.845956] platform cxl_host_bridge.2: host supports CXL
[   43.847301] platform cxl_host_bridge.3: host supports CXL (restricted)
[   43.977427] Fallback order for Node 0: 0
[   43.977432] Built 1 zonelists, mobility grouping on.  Total pages: 1921387
[   43.981915] Policy zone: Normal
[   44.020453] systemd-udevd[5549]: segfault at 2d8 ip 00007fe6821188fb sp 00007ffc23b3ddf8 error 6 
in libc.so.6[7fe682028000+175000] likely on CPU 10 (core 10, socket 0)
[   44.026953] Code: 38 00 00 00 0f 05 48 3d 00 f0 ff ff 77 39 41 89 c0 85 c0 75 2a 64 48 8b 04 25 
10 00 00 00 be 18 00 00 00 48 8d b8 e0 02 00 00 <48> 89 b8 d8 02 00 00 48 89 b8 e0 02 00 00 b8 11 01 
00 00 0f 05 44
[   44.030103] systemd-udevd[5546]: segfault at 0 ip 0000000000000000 sp 00007ffc23b3de00 error 14 
in udevadm[555bc1b0b000+13000] likely on CPU 21 (core 21, socket 0)
[   44.037169] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   44.038736] systemd-udevd[5542]: segfault at 0 ip 0000000000000000 sp 00007ffc23b3de00 error 14 
in udevadm[555bc1b0b000+13000] likely on CPU 16 (core 16, socket 0)
[   44.044359] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   44.054368] systemd-udevd[5521]: segfault at 0 ip 0000555bc1b4039c sp 00007ffc23b39640 error 4 in 
udevadm[555bc1b1e000+3c000] likely on CPU 3 (core 3, socket 0)
[   44.059207] Code: 00 49 89 f7 48 85 f6 0f 84 e1 01 00 00 48 83 bd f8 b6 ff ff 00 0f 84 f3 01 00 
00 48 8b 77 20 49 89 fe 48 8b 5e 08 4c 8b 63 30 <41> 80 3c 24 30 0f 87 ce 49 00 00 41 0f b6 04 24 48 
8d 15 8d 40 02
[   44.068095] systemd-udevd[5550]: segfault at 2d8 ip 00007fe6821188fb sp 00007ffc23b3ddf8 error 6 
in libc.so.6[7fe682028000+175000] likely on CPU 15 (core 15, socket 0)
[   44.072347] Code: 38 00 00 00 0f 05 48 3d 00 f0 ff ff 77 39 41 89 c0 85 c0 75 2a 64 48 8b 04 25 
10 00 00 00 be 18 00 00 00 48 8d b8 e0 02 00 00 <48> 89 b8 d8 02 00 00 48 89 b8 e0 02 00 00 b8 11 01 
00 00 0f 05 44
[   44.077917] systemd-udevd[5551]: segfault at 2d8 ip 00007fe6821188fb sp 00007ffc23b3ddf8 error 6 
in libc.so.6[7fe682028000+175000] likely on CPU 18 (core 18, socket 0)
[   44.082883] Code: 38 00 00 00 0f 05 48 3d 00 f0 ff ff 77 39 41 89 c0 85 c0 75 2a 64 48 8b 04 25 
10 00 00 00 be 18 00 00 00 48 8d b8 e0 02 00 00 <48> 89 b8 d8 02 00 00 48 89 b8 e0 02 00 00 b8 11 01 
00 00 0f 05 44
[   44.106770] systemd-udevd[5519]: segfault at 0 ip 0000000000000000 sp 00007ffc23b3de00 error 14 
in udevadm[555bc1b0b000+13000] likely on CPU 1 (core 1, socket 0)
[   44.111751] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[1/6] 🌒 ndctl:cxl / cxl-topology.sh                         1/600s

at which point I've lost the system and I have to reset it.

I suspect the faults in udevd have something to do with "plugging" in memory, but I don't have any 
ability to inspect after this point.

It appears to go boom when attempting the first test in the suite, cxl-topology.sh.

So some basic questions:

- Should the above sequence work with upstream kernel?
- Having noticed that the nvdimm.git kernel went dark, I thus tried the upstream kernel. However, 
from the mailing list I learned about https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git.
I have tried the same sequence with this kernel and a various few branches/tags. No luck. Is there a 
branch/tag here for which this sequence should work?
- As these tests utilize a mock driver to emulate various cxl component(s?), I have found that there 
is no need to run this on a system with CXL components (ie real hardware of qemu), correct?
- Is there other documentation for learning how to run CXL tests other than this pmem.io ndctl write-up?
- Is there a better/preferred way of running tests beyond this? I've seen reference to kdevops, but 
am equally confused as to what it can do (in part because it appears to use the above mock modules).

I have seen the email thread "Usage of tools/testing/cxl" started by Raghu H, but that didn't seem 
to answer his question (similar to mine), and instead pointed to run_qemu.sh. I've started to look 
into this, of course having some difficulty. Perhaps a quick overview of pros/cons of: 
tools/testing/cxl, kdevops, run_qemu.sh (and anything else that CXL developers use)?

I greatly appreciate insight/help in this regard!

Thanks,
eric
