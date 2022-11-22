Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D826C4167B
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Nov 2022 09:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiKVJzA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Nov 2022 04:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiKVJy6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Nov 2022 04:54:58 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2136.outbound.protection.outlook.com [40.107.22.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A57719006
        for <linux-cxl@vger.kernel.org>; Tue, 22 Nov 2022 01:54:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdOoE6epU4vQytdb52k0H4LcvjUzqtVIps1gEnrNUnBiM3c/vvKi081St0fqZJGKHJ//J682JkmTz3DPL8fMKt/Ce5565n6deS04KX9NdkKQJvNgYreHkrHxPTmhpBEfbml7D8hcJxCkTFL5/c8h9RxlDYgNDOu/Q+e5RpaBE+3neUYoy1oO5B85lGR0wBXDNVxJ5eDwaGwU/GFufHDMmyeM0u8M/V3m/7qzT6vtCzMOzV4vWP9YRUE+58EF3q53zlpXKYguw1tmb0dD0DawPgey+5IvZMAQOii1fxDNnRmxSZpmiYftsPkPDld+BwcF7qT1V4TGzAe5HTTPOWqt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QULrpXuFMSz/xRSzwKCG8aKnt/TKZHJV4t0D6EJcBY=;
 b=lsZCWB2WaPM26ZUs7sy2WyX9IT+70wnPTL3KxO0N79klstcs2Bod3Nj9a+PXFiDD58syyKK8L/yej+/zRCSIIAtDboBlpfb/Kl2xxjxIjXSXAr7N27pIjUBVohyOkgBB+HpRAtflbXW4sd9PxfOZVjmfCPMZMt1OMf/uuRThWtXsvuxfVq9Ybv+AUinUVvvAFmy3+c29sL8SN2FIL+4FGwunNzkBoKedeB1U1JOGaoDswNKKO9V0GfxSYFd42asMkL9ig11U16OS+LVqHV3eL9w3ERbhyUi/rl+F2RpfDjeK4cCiArlORMhGtRtGBqIPkr6aeplBy4DaQObyrUSYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sasfermat.com; dmarc=pass action=none
 header.from=sasfermat.com; dkim=pass header.d=sasfermat.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sasfermat.onmicrosoft.com; s=selector2-sasfermat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QULrpXuFMSz/xRSzwKCG8aKnt/TKZHJV4t0D6EJcBY=;
 b=g09BQ1i3TyD47RP5+RWACkOluEO59QkBrlc+19c545IaFaook5AETA4z38S8nBKnC8MXjW7RRK1338goFQ/L2yCw2dfCbpUXl4b6oWBvElrV3lUC/9Ih+z+njmJemitPoUJ5mIpKkKsDpGx0nfaZX5nkjo5W5VganIv6Xe5n0mQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sasfermat.com;
Received: from DB7P191MB0377.EURP191.PROD.OUTLOOK.COM (2603:10a6:5:10::13) by
 AM0P191MB0737.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:157::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 09:54:54 +0000
Received: from DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 ([fe80::7d96:5b85:595b:a42f]) by DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 ([fe80::7d96:5b85:595b:a42f%4]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 09:54:54 +0000
Message-ID: <40fbb3ef-ccf5-bfbb-675c-861948beba56@sasfermat.com>
Date:   Tue, 22 Nov 2022 10:54:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     linux-cxl@vger.kernel.org
From:   Julien BERAUD <jberaud@sasfermat.com>
Subject: Prototyping on CXL hardware
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:5:10::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7P191MB0377:EE_|AM0P191MB0737:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa45d2f-c56f-4061-cd1c-08dacc6f9b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fUj8litRlvTVlQFObQrmHl1KbsgY23ToagfZjLWxTCHhSSj4u13+h2ckKqzeqTCC3J0ySEvar43fbiKlnyQdsYKYKJQUJw6AHYcDfXFOvLtGFMpia4eXUx3uQpzYAFb5Ruajfn9Z7qYLqcI0+hcMWFKvZASWu1R6JNVRyBtEaBYAdsswFgDH9T+HKBh6hqkquFDjUta6xrcgBh84ENcCznFs4gOfsv3E5FX2g/5CKlAUJWHleq+00RJfj6zPqJ9GjocdNlyKEL56hO0FbAj7X9k3evREn6WUhCfs0tBmIUWzoLPcS9u+Tu03XJRBszEmSe7Uk4cO2jS+EAsEEm1rRTmNdCRmSMIfSptvH1+u0gZjgxSXqs3fXs58wAzD3Xdz3gpoe3+af1BDnItgj9gPL/6LCUgFEInf9So40B3PlNdtrWihKQS+pf2ETsZrbLP1zx8T9msPo1VF8qJtanWZDHbuMeGnNrUw5QrjIdYt1jAXmZtyNBsm/kX1TBonWNZkPwUNOs5bAH5v4LY8S7ot4tZW0S7WAPaD01ZrCHAAifmA+YhyjsSxiiL8hEL12sTX9KEsWkHU2WDgurlc9pYLyvQiDAat2/jdELJKDz3eJKSV71EzOpaSxxXKTZLSNkY4gxTMhn2S9/2YslHX36NJPQS2nxl4m6iEsKStfauIMs05L/nWVMIvgDy77hi8A7NtVB9TVQCLZ05IjwCb98msbqC0pAzYvwlkAwKzlkuCw80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7P191MB0377.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39830400003)(366004)(136003)(376002)(451199015)(6512007)(186003)(2616005)(4744005)(38100700002)(2906002)(5660300002)(6506007)(6916009)(66556008)(6486002)(8676002)(478600001)(66946007)(316002)(8936002)(41300700001)(66476007)(3480700007)(36756003)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhlTnBsMTZ6QytZTjRXQ1E4YkRMUE9GdDcxM2x6K0VUV1prNnlpWXRMZ0U2?=
 =?utf-8?B?L3p0aGd4L0FjcmdmRE9DVDY4SXJKUFpuWGQ3MnVJR3VtamJ0SUl3b0VLd3By?=
 =?utf-8?B?KytVQ3BDeXBQQU1RNzgvVk9yVWRiRkdhdEsxMW1Xem0ycXlQd2ZuUnl1dXFD?=
 =?utf-8?B?a0poc1krL1RWNENnUVRkRkgrVkNSV09ZcWE4ZE1EYkpIRG9DdTdZRW5CNG9m?=
 =?utf-8?B?bUpHbXJ6WDJNdk95b3NlcjBSd29JelZaemN0Y3RacE9RZVFuREpPYnVsYWlq?=
 =?utf-8?B?eG1UUDlMZGlSUXVZOExORmp4WFh3VDU0L3g1SDZnTktWeTlnbldHeEpyeTJa?=
 =?utf-8?B?dVp4NDdNRVQyNWNjU1VSQjEvUGdIMTdrcmlrblNPaU80SEVZY3lMRTAzVkxv?=
 =?utf-8?B?S2tRcitpc25zODhiMW5sbmpVbTNBZWg1OWl2WUVQNVFObGZrSlROdmVtMlk1?=
 =?utf-8?B?WTJEeGwzWkFOb1NoRlZFWHU4RllJQStCU240ZDUrZUFlbWxyVS94SlVjK0Vp?=
 =?utf-8?B?NFhtSWRSWkxWRVhvRU5Ca2hZcnVSaWpOY1NhN3BDNUJSNWRsbmxSUWZrb3FF?=
 =?utf-8?B?R1dVN2FhR1VOWjRVL0Nabi9hay9QTU1OaW4xMXdBU0FFTmtoNzZlV3FsYXd6?=
 =?utf-8?B?ODNoOWxQYXJHRDkyNmtSYjNhV0FSNFFTQXlDd0tlUmVwcWJPNDhmQ3ZoTlNB?=
 =?utf-8?B?VlNhUmNtQjNZbWN5c1gvbEdVcytaTktvYi9uUUFXdXdrZy9nd1hOU1ZjN2Yv?=
 =?utf-8?B?cXU3WE4zRTdhNjRrVXgwaFR2MGhXNXl6QStzU0R0cHFsZ3YxbE9jYlRlbjVC?=
 =?utf-8?B?V3pMaXBWK0xzbktRaWFnTytLei9naERkQWpsbjlhTFF3M2hPZktxWW9VSENL?=
 =?utf-8?B?UXZrUmFUdkF5MzdNUFpmdURFSW05S01FK1RDQjhaVS9va1VOb0pqaWxqTXVt?=
 =?utf-8?B?UEx6anZlRUlEVktVR3VXaE1wUUNxVzl4NzN2TGVEblQzek5CeE5MVUtBVENX?=
 =?utf-8?B?R1dxc0lUellJSityQncxQXk2QW9qNDBFSEtGRmtiWFhCRk1JRHcvSTB5S0xZ?=
 =?utf-8?B?SSs3U2Y4eDFIai9rR2ZRZENaVE1MV3J5V3cvZC9tdFkvMys1NDkzV0FVWDRT?=
 =?utf-8?B?bmQwdlJaT0xLVGJoTStCUjBpNWg4WE9MMkNkcHFFaGFGbzJyeVVaSU1CS0g5?=
 =?utf-8?B?VHc5dklXM2hITFVaT0hwYm1WalRjVDYwQmx2MjA5bHJ0d2RockdJQjNCMWl5?=
 =?utf-8?B?ME1HTmFqOEpXN3BZSkN2R3lpc25RR0tHdkZvWldFWW1Lc1RDWXZ6TlpGVE1u?=
 =?utf-8?B?Mkd0UEhDZG4vV2FaeXpzdWlJamE1Q2FqbkE4R0xvM2FFUm5mSkIxOHdrWEsv?=
 =?utf-8?B?dEhwekRKWnludW9ZZ0p3aUx0WDNiQzM0L2dPTG05VnJreEdpbDRva21JeWxC?=
 =?utf-8?B?RUlVWC8veUZIOC96N3BQbTJRRGxlSDF1a21YUEJCUExxb3VUbDF4R2F4TEtB?=
 =?utf-8?B?VnU2UEpEMHFsM0Q4dzhvaXA4V2UyYnpRMXQrRVJvZ0Z3elNGOFJXQm5DNm1i?=
 =?utf-8?B?SndxZGxhT2MyeG12TUQ2QStTZjBJenl0VGI3endTVTFzRzNRaU10dVRhZ1Ju?=
 =?utf-8?B?L1gyRXdZQUMwN0R1TEFyRGJHTGhvWFVTWE1DekxNYXJWVnA0OVJIMW01Vk5X?=
 =?utf-8?B?N1pzdDdiM2N3NUN6RXNPWGpOL0VNT20yOFVGZi9JaXN1dWZUTGdFUU5kMGRh?=
 =?utf-8?B?d25IRFBqdEVZZkdmWmpqQUpHWFR4OWlKMFo3aG9nZS91V1cvYUM4QktJTUF6?=
 =?utf-8?B?TUtsZnJRVUxON0lOYjhiYmNRUUo4S0ZaZmQvWVVFU3ZWbzhHS2F2Y21BN3Va?=
 =?utf-8?B?by9BcWwxKytwZ2FadzN2dmRvNXRvd25GVmx0Vk9UM29IdnlYL0hEVFl1aTF0?=
 =?utf-8?B?NU9yWTVVdkRxS29ya3BlaXJGTjBXOWQyYUxQcU0rblcxN3oyMjJCSnI4TkNS?=
 =?utf-8?B?cXQwODRaT2hnQmJJQXdVWURyRE10SXdCcmw0MW1SWVhxQjkwekVHTW1HK2dP?=
 =?utf-8?B?aVRjbklvRTFrNFBkZjR2bGZHZWRDVFdUcnB0dGRPUENnaG1iYjhSRS9TenN0?=
 =?utf-8?B?UzNNdHhhTitaZUJGb1hLWEpsTXFpTGZ3SnpTc3NwQ1N3ZzV3QWdvMDJBNG9Q?=
 =?utf-8?B?TkxQR1VkNWdKeVhMcXRKYVcxQ3UrV0ZFOFNoc1pSU0xIV3hIdktNc3VOVnhp?=
 =?utf-8?B?ZzZjNFRpdWczQjIvdzYzQkIxY0RRPT0=?=
X-OriginatorOrg: sasfermat.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa45d2f-c56f-4061-cd1c-08dacc6f9b36
X-MS-Exchange-CrossTenant-AuthSource: DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 09:54:54.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e414563a-f0c0-4cc4-8c4d-f4cf6cb1255f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogrEbJThwAyytmRF6ThuCQnNEga88anR78EPPpPcTBOqpM8+F9FDeubm9exXt2FSrDiBDIrMxyBEqCJirdzFiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P191MB0737
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello Everyone,

I'm currently trying to prototype with a simple use-case on a CXL type 3 device
directly connected to a CXL 2.0 capable server.

Since I have seen many patches being integrated in the mainline kernel, I am 
running a 6.0.1 release.

The init phase of the drivers fails with the following trace:

cxl_mem mem0: at mem0 no parent for dport: pci0000:16

It occurs at the first iteration of the loop in devm_cxl_enumerate_ports 

The previous steps have been succeding as far as I know.

---------------------------------------------------------------------------------
So I have a few questions that I hope someone can answer here, I am sorry if they
sound naive :

- What is supposed to fill the device's ancestry, and what does it means if there
is none ?

- More generally, is a CXL type 3 device directly connected to a CXL capable
server supposed to initialize correctly on a 6.0.1 kernel or should I use a more
advanced branch ?


Thanks in advance for your answers,
Julien
