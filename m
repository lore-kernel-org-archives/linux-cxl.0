Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ACD1CF2BF
	for <linux-cxl@vger.kernel.org>; Sat, 14 Sep 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313401; cv=fail; b=hPiJg6T17N8wScxIemYgIrPojmMyJeNWYq01Pq32BvatyBnH0V+7H7KiJwS5yTMTatVbahbokdN5GVNL8/bEdwxUraRGnn6cItXjVNjBUSPVOhQXn80xW99x1kC54pqWjjScRkj4dwDxf8mR19jPQPT/YeGqVkP3TpDlM5VAAZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313401; c=relaxed/simple;
	bh=1XyZElhCajkAO7Pw8xca9vhh2qbTsUWSuyjMwdTVnbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UcFU7A8N6+BaZF4aMn+ohlWj6C51CxKzWJC4e6R6IUuk7nZfaF+80liFrWa7atuHcJkc8yZAW4BuPzTLc2j8h/ju2p4pig144Ut3qms0NX2l6PSRkt+u+sHYOzqszsO/9T8bIORlA340Wabw5ni/r+x9PkI1fFtGh/Jg9CTucpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=jS4wenEG; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="jS4wenEG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ts3p0iLTdTYLnAHwQzhtsr5dwYiDhiseF3FTzWwRB70HSEdqvp1+SbIHuZZRQLNGY6NG4f8autIM/HObA25MAu496iZE7OIyVo6C2kqa+z1ARVgHcdTP9GCE0b4Y1sljGoTgvuKFRd5bd0aPCSy7DQlwDtKY3eTfa01jXMMUylXvmofn4DcKPJYtkKiz0Sy+k++Qj6VQA+jfFJXBIOaj2qIEF6OBKsCtKdwpkKiazj3Y/j1Nk1wz+aIiTPcATwqm7NdKyuc9ZxZNGzkuerjhry34Q52EHqrzv+O2uTcBQDVejhzhigFqsj3EX4Z/Or7s2kHXpfBij+CbWU34BVGKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO+gHMsnHONx1BlbvqV/mYPnO6zsq0BZbF27dyW11AI=;
 b=W6nkvBETX3hc6GjFpSNndjyXeECulmwMK95QXBcSZ0tB5yJDQMnZnW75kSESBGV+mvGmLYok/0BT5Y8i4DacCy9IcPgwvAKrMxcPg90S2oETzisJI8BJuLPWLjxm0yl9QWUj0PVz0O49jvsSOUve+IAvC/jVA3XUQtcx+jumNQYHLXG02ffuCFuAVEH+x+Ex2DflPbfCRXpucxugE2apfFec3+XYZBRAz6RywWd4bnlW+Ty+yRiflRXRFp5qX7olzQhaRFxP3Ys5TPL33zXTLWcyh6LeDWdpqhsMLUgLE7Cod+4ihWucalx+Q5TjmrTiZOF7C/f+mqj+bdIMEcPGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO+gHMsnHONx1BlbvqV/mYPnO6zsq0BZbF27dyW11AI=;
 b=jS4wenEGx3Zs4lrqJwJRywTm+/jyUJ85MS2cJ0dqtwXNRVywQuGvqT+/8PR6roxVCgg9WxKOQ2skvu53zRDRX5xmcGmId2HEMx0OhXZbtbzO76qAu6yjMqbbzCH0vEg7FpxJpaFWRwVFdFftWCqC5Ppep2KJkaS6lT+NvLa33HBIYvbA4OuT8g6ICvnNp+qxguutvQ5Rz5QLlm0VqhiWAdOcGgeMkKTNp4/vo28g1OX91hYAeLSMRbRc+PFIRkZiNvXeaBYiOd7mXXC0VhBX87ZBukptob6OfxpRRYh1fgwehu9Tk+rYaq49An9wDDE0aSeHjwEjx/QInbSbyXo7+A==
Received: from BL1PR13CA0154.namprd13.prod.outlook.com (2603:10b6:208:2bd::9)
 by MWHPR08MB10013.namprd08.prod.outlook.com (2603:10b6:303:279::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Sat, 14 Sep
 2024 11:29:55 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::5a) by BL1PR13CA0154.outlook.office365.com
 (2603:10b6:208:2bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17 via Frontend
 Transport; Sat, 14 Sep 2024 11:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sat, 14 Sep 2024 11:29:55 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 14 Sep
 2024 05:29:53 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Sat, 14 Sep 2024 05:29:53 -0600
From: ajay.opensrc <ajay.opensrc@micron.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@Huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"john@jagalactic.com" <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, "Srinivasulu
 Thanneeru" <sthanneeru@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
	Aravind Ramesh <arramesh@micron.com>
Subject: Re: [EXT] Re: [PATCH] hw/cxl: Fix background completion percentage
 calculation
Thread-Topic: [EXT] Re: [PATCH] hw/cxl: Fix background completion percentage
 calculation
Thread-Index: AQHa4aFnXFAhiNhGOUK/S8twyYFQ27JR6UmAgAWFZN0=
Date: Sat, 14 Sep 2024 11:29:52 +0000
Message-ID: <edbfbc67684d4fe5979632d2c01bffaf@micron.com>
References: <20240729102338.22337-1-ajay.opensrc@micron.com>,<20240910130723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910130723-mutt-send-email-mst@kernel.org>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|MWHPR08MB10013:EE_
X-MS-Office365-Filtering-Correlation-Id: b39684fa-7c2f-4050-a4fd-08dcd4b08ea5
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?MfO55stOirKXZQOLudAJBj1P+7kCWhpL4EmWb0Gp9S8Q6EUZ24Dqg9Ii6c?=
 =?iso-8859-1?Q?2BAXtb/TUfDFWqgLw24EBwE72CWIPF24CO3fRxyYTi8u/tnsxMVKCQfRT1?=
 =?iso-8859-1?Q?qU+fqy3O+/7QagRHXXGOUkWLBGeVlLarKUkP/9esID7QMo4JrqbeI3NvO/?=
 =?iso-8859-1?Q?0ZC0zB2PCOy8WyNq9Y0oXkVv+PNXctORzElxiYxMkLSPzDZ1bXycIpEZeq?=
 =?iso-8859-1?Q?7BMvZ7uLgkfLhK7V6biFl3O44qs+S9nVMlDz4VTI0mFvFFARMGjCAUJJRJ?=
 =?iso-8859-1?Q?ISR0d/Z5ojauo2hnXGyWA4JEXG9LQwUF6/u9+nGov71liZBklRxMhBD2Ta?=
 =?iso-8859-1?Q?FgKThje5xq8JQ7MPwtcLnj8hujzFagl3zFg8HNXkltmwFhKrAyS29gUGg1?=
 =?iso-8859-1?Q?lb7pp5Xup1bTvX6+o9gzTbPummBKPSu9LBUy8aBguYyJkq1bn64znP7Y65?=
 =?iso-8859-1?Q?TDmWY2LDBlQYEuh3veK3q7Q7shu6rHGeAd+6mk0lLpfu5uHA5UfMMN+vpl?=
 =?iso-8859-1?Q?ovGTAk3yl/1X01PxcQxmloaMaXCVRmQAn0YAPybASN3FSW1dqgy7OATuPb?=
 =?iso-8859-1?Q?HCoX76Qb6xYSSUDd59xvw/1hQW4TqkhgpvcakvkPqoK21L5O6aNqdfhMRL?=
 =?iso-8859-1?Q?8NoOmRHZ4gAswMkzvszQq44h1jO6n71PR0Ot9GHIhu/U5uA2DPomHMKP9U?=
 =?iso-8859-1?Q?I1A3cmMppmngKU76ClYp1CaIGsQmtRk9dvEWBgJP0XTy9b1OLslBhwr1eS?=
 =?iso-8859-1?Q?lkLsV1Ufe03rsD/D9bdtKQdfeV802OKZAG2CrVijfsPr4vzj2/yFVbfK5u?=
 =?iso-8859-1?Q?fio6tWJctsbPtIhKTixa3+eRzM5/luqgLrWABTwaHFEo+VXwAPxrTKuSxG?=
 =?iso-8859-1?Q?hPJHCnhVrBWuZCTDbXaEtVTJpYQSji+9r4TmjuN446NjaFq8U42ASjEwG1?=
 =?iso-8859-1?Q?4Q49H6Pso4QkPmdlX0ftf2p+eAg6lCunfz5cg+MPOlvkly7zpylXzG379j?=
 =?iso-8859-1?Q?h5VvCQ6oM2aersoTooIdj1n1L/IZ5nmgyuRFkqbZmQjGzEnrN2bsVwyk3h?=
 =?iso-8859-1?Q?rwr+KmRdRm5GFG3zJe7/r36ggLvh+I0MrQpyx/Lh6clmDuLi0SheZgGxIl?=
 =?iso-8859-1?Q?MxwxP4BRf1GqbaakUvqC8kQKdkj7M2xG0OF/4bdgSPc4ot7CI/SxlLQdZU?=
 =?iso-8859-1?Q?ls89uAGCL6ZwEGB8bgENiXtuO53bLoDXM9k+kQMbDR43tEUKrRRq7sHYS5?=
 =?iso-8859-1?Q?/LcmL/NODjV30IMfwAnqPUnECAyWDOviMvpjQY1/zYudebHGm5gudniOpF?=
 =?iso-8859-1?Q?e+B0gpk0uuSY63Q0kFfrq5KWaEk7ghrHRmmyRPqKC066hOvWnhshkXTqOZ?=
 =?iso-8859-1?Q?fXDioSWDEBSqVZumReqcKJ4G4X1CtUNbrmYHduVcqSeb61fV0EeV/3gmIM?=
 =?iso-8859-1?Q?RbouBMQswTd5/jPCTsPM0Tk7eZryUWe6mLHGIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 11:29:55.0758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b39684fa-7c2f-4050-a4fd-08dcd4b08ea5
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR08MB10013



>From: Michael S. Tsirkin <mst@redhat.com>
>On Mon, Jul 29, 2024 at 03:53:38PM +0530, ajay.opensrc@micron.com wrote:
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
>> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
>
>Keep all tags together with no empty lines pls.

I have resent the patch with the all the tags Michael.
https://lore.kernel.org/linux-cxl/20240914112021.2730383-1-ajay.opensrc@mic=
ron.com/T/#u

>
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
>> --
>> 2.34.1


    =
