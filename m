Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1D17BECA
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902944; cv=fail; b=jORHLMsjVfU9kI/uuoeQv1AWN0yz39bJQiClc9+hfcIvoBY15rprbQgRYQ+bRCOBstjnsWD/QvCfrYSi6+fyDTP6crNgws+welZa/tmrI/Qxs7aOg1DpgfClG/k8NYtK7Dqq3UMQNb8yRWcF0XvwCWZEr1aGfxqVd4IjUpljzII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902944; c=relaxed/simple;
	bh=Dk9UBFOW/dQkGFgIZySEULpx37xma6OiW+ac2+RQbXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nJu3BQKhI+LYkKdNBYb75wh0Lpd8QGiPvhW31gaSyo+BT1cTNYF9hUyvgYJwn54S3wYh8Yaey2VcHt+0sgsrxdZGdhhmPGK6sM/RgY/Q2HLwL62ci5/IVTjbBFPhnjk7EG3S8z2x+NsVmsISWvTfNj+NiKJozCdlrmhquWFQYlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=JmZZNOE0; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="JmZZNOE0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOy/pyjTj9PlLtxMR2lbJUjo9q/aQ9hGWuj+do241GDfmZGnf5IFDgBlkxzy0Rb/AzolmHs/P8iZcrJD+QvcRFGC6gxc3B6uYCsDH2l0LUMMncgVmDHOpfIypYBx48deLJGa+AyBN+N7lZddNlTsb7iaE+Si+/R6gMkB/bllcqJWQilUDnGlGnp+KTvA1C4CUMIs5bzRafo12iT85FWOZ71cWweBsQrva34AOjeYGel9CyYv8y6+orwTJUi5MAYiGWddGj5JZdYrlsUre9fq7QNAbKUhcHIXDaJ3FhKvd/IzEqpCC51KssW2TCkr1z4OAoJJFeNLIDNCuvnFL7bnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST/P8q7hkpC02+JORl2ayKESxPgc6mrrFv9n56gmXwM=;
 b=k1L9o7eQJjwuyIbQxNDmglk3vBLTT4h2BahkE4Pw+umdIgiFWekXLTdt3XCo6Q1brwKm91HxopMndjxvd0jnx4uu8mSBidclnmlXzrs8xKMNJsALCiJCYxJacRNSMFjfFEUaN1tSlpAiPCtnGblKQTzHqkd/oJsXWolEUcGUYAIWjvJFthGAfsmP24oL0CaoOT1whMp+IJJHmNxDOm6wIu2GYggIHsF6iEW2xzfX1azg+GTYtQmOfINfFD+ydHJ+jpqYwrkOV1iUxkBzVCcIyQMCDhyhKkyIWf4O9L6nJgEFsWQZgEH/WQOFhrXFD6OOgZmcE4Q712u3Hlc7vld1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=redhat.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ST/P8q7hkpC02+JORl2ayKESxPgc6mrrFv9n56gmXwM=;
 b=JmZZNOE0L84U4ep2wwtzitEe2DwfhyOjtpt/Wy69Ctilt+raQn7P51/Lhlx48vIyRyKXsQSl1kFkDiwX2PhsnLHzYhu9Z6m0TWEwyeDwSYK1biK2CeBXp31YSlqEoplSlk0szruTEshk/zPnuXCi1DKL/QHqm+i6lCuJBFtYIA5Fv+avBuQGzWxAebQdmp9FT0U4x5++b314fpduQzUkB/EP5dETdgTNu3CxnAgp9jH0SpGgieGgF1gHzw+x7tkijZSelSk9dVIHJCxFFfLgM5QtbtXpjq3NxUkxTYMyYO76cMXaFhTqP4olVnNGAFF/YUhr1Sd+dPOhny4CafZy3w==
Received: from SJ0PR13CA0175.namprd13.prod.outlook.com (2603:10b6:a03:2c7::30)
 by SA2PR08MB6587.namprd08.prod.outlook.com (2603:10b6:806:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 14 Oct
 2024 10:48:57 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::22) by SJ0PR13CA0175.outlook.office365.com
 (2603:10b6:a03:2c7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16 via Frontend
 Transport; Mon, 14 Oct 2024 10:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 10:48:56 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 04:48:54 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Mon, 14 Oct 2024 04:48:54 -0600
From: ajay.opensrc <ajay.opensrc@micron.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "mst@redhat.com" <mst@redhat.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Eishan Mirakhur <emirakhur@micron.com>, Ajay Joshi
	<ajayjoshi@micron.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, "Ravis
 OpenSrc" <Ravis.OpenSrc@micron.com>, Aravind Ramesh <arramesh@micron.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v1] hw/cxl: Fix background completion percentage
 calculation
Thread-Topic: [EXT] Re: [PATCH v1] hw/cxl: Fix background completion
 percentage calculation
Thread-Index: AQHbBpg3y5v2dlN91E23qENSwuUYUrKGmnsA//+k9+M=
Date: Mon, 14 Oct 2024 10:48:54 +0000
Message-ID: <b0f8fb6d88bd4d9ba5b369babb94a423@micron.com>
References: <20240914112021.2730383-1-ajay.opensrc@micron.com>,<20241014111216.000014c2@Huawei.com>
In-Reply-To: <20241014111216.000014c2@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mt-whitelisted: matched
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SA2PR08MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e18bc60-b650-4d5f-4373-08dcec3dcda2
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?dpRW2SMFByZ36uvN/sTfaLRbz6qPV8Ht7AfSbGBfE+IPHQRNQN5QaaeHru?=
 =?iso-8859-1?Q?V7WZik3LmifcYg96mGiyXpESW3qxJdVzRQVriK3v8McRqTs415R/lTbje8?=
 =?iso-8859-1?Q?gWOyXzXgsuL/CUjDVrqP36BIFjxAIo8iPoZpKEmA0ZD1qlIp02jjkJj1Va?=
 =?iso-8859-1?Q?xJSAWDSFVDntMGKLUdfNgKRYDLTEvzTGw9swTohmiYBadYP0kJn3AETGBG?=
 =?iso-8859-1?Q?QYLL7uRt4ucSrbFKAHNMox5PsaCc7EOcyo6JiE9QjTR6pkirEbH6oQAnOg?=
 =?iso-8859-1?Q?hFTeGl3bpuDwsEEyN+sxn4hqxPOa+H9Yp6y/ssiya6u2JQ5IVlR6BC6p0L?=
 =?iso-8859-1?Q?+aH2+n/ANZwpmll67c9eWP+00g2LuPsNyRu6ULSc6NAPVFPRDqQujpfURq?=
 =?iso-8859-1?Q?qSaFtWmPHkszL/QP63/lNBCR3DG7rz7lcqqAaCfneLFJ3enBLaTCuNbkWi?=
 =?iso-8859-1?Q?Ly2EyDicd4XqzIdfkM0NK7WEYdxQG+1Trj8cKzhMczmjp3oU6KrOF1xqKG?=
 =?iso-8859-1?Q?l2BbwZ2oy0Ib6Pi627g+8zws6DqB7IlAQsww5S1wEOYzMct9kJN65UxlOi?=
 =?iso-8859-1?Q?HCHs6OjNqHEE3gLXuHMfj/baBwg+AW6zIFM/1tAerdgnuscX03S60rDDcW?=
 =?iso-8859-1?Q?NCe/tIIGL5SCCPgq8DkrPK8gyq+WvEBYHlBeym7ttruIBtnULB5FPZu7Fd?=
 =?iso-8859-1?Q?GV5pmSMG0ipJ4CaZ1wJ0qVo7zsfv2B+0CJeIG5kVALR//dbUWKNjBUHVTp?=
 =?iso-8859-1?Q?pmJGEBwN0BQYD25wAIE+ZpBgFoJ6SISlYg3Ll2mquKqpyXzTFyH53YhYF+?=
 =?iso-8859-1?Q?jgtKiucp4z8tZpbY63BW7c89OlUjllzuW0zuKcoH29vIXbADjxbhVjcmBE?=
 =?iso-8859-1?Q?wOp0q1AhEmevClVWq1M2gZ4JHRgRE02B/JQLRcyiAJklKdxgTnGleF2FJz?=
 =?iso-8859-1?Q?FulDSRr4HeIZ+6GUWweaPBNf/75/qwrcd9qs8MpB9NQ38C5MGvcX7C/H5d?=
 =?iso-8859-1?Q?WM60k+zdhcyfoy4eFEFqZpCNTZeWChD4cMezK2p1hkAm048HYDrN9arL13?=
 =?iso-8859-1?Q?1d6isrmDE5v7QHLNiJ6+RgqtzULSwPDNRR9XLjGGRqwdIMdcvY3pzYo7Wk?=
 =?iso-8859-1?Q?iuCLFfYgs5yUIlHdbUt1g+FwvjfSoW6VaTmrvcYEEK0JO7cJ3muUPpAWn+?=
 =?iso-8859-1?Q?1iggcwl3GKahsD+hnFyEKJWdY7p8T3Jz3RGbD3V4zRC33o2U9qeRQFmUn3?=
 =?iso-8859-1?Q?zQU/t3TuYRpdoib23Q7P03T+za04x26wm0ooRCb1UStvMG7O0GBygdqnAa?=
 =?iso-8859-1?Q?56a0VBCJyvWYwGJD8XfanK/z4JtnKF6TEzM5zj1AAhrPoMS4/Lsec/UR0R?=
 =?iso-8859-1?Q?OPCAoAA7jmMJ0Ke4Fr67J2xzpD0lYXJSUbhaafhu5SIa2gbaDWBbruEwMt?=
 =?iso-8859-1?Q?RMN7sjBK37KBIvrm?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 10:48:56.6110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e18bc60-b650-4d5f-4373-08dcec3dcda2
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6587

>On Mon, 14 Oct 2024 10:32 +0530=20
><Jonathan.Cameron@Huawei.com> wrote:
>
>On Sat, 14 Sep 2024 16:50:21 +0530
><ajay.opensrc@micron.com> wrote:
>
>> From: Ajay Joshi <ajayjoshi@micron.com>
>>
>> The current completion percentage calculation
>> does not account for the relative time since
>> the start of the background activity, this leads
>> to showing incorrect start percentage vs what has
>> actually been completed.
>>
>> This patch calculates the percentage based on the actual
>> elapsed time since the start of the operation.
>>
>> Fixes: 221d2cfbdb ("hw/cxl/mbox: Add support for background operations")
>>
>I'll include this is a fixes series I send to Michael + list later
>today.  However for future reference, no line break between tags in
>the tags block as it breaks some scripting.  I'll tidy that up.
>Note I think you missed Michael's point about this on the first version.
>+ as a second version, even without changes, this should have been v2.
>

Thanks Jonathan! Got it.
Sorry missed the versioning, will be more careful about it.

>
>Thanks
>
>Jonathan
>
>> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index c2ed251bb3..873d60c069 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -2708,7 +2708,8 @@ static void bg_timercb(void *opaque)
>>          }
>>      } else {
>>          /* estimate only */
>> -        cci->bg.complete_pct =3D 100 * now / total_time;
>> +        cci->bg.complete_pct =3D
>> +            100 * (now - cci->bg.starttime) / cci->bg.runtime;
>>          timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
>>      }
>>

    =
