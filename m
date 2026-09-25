Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC241DE11;
	Fri, 25 Sep 2026 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335030; cv=fail; b=tGLF882h9EjTuOTlBK/LlAWtyaQSFZanIq9cd+7hh0DFwsSKgU1z6BXGS5R5FDrbCtY+WbGk7LemmwlPZ+LPJB+6z3vVsAgskA/1bHPzYwMxVhJwbsUlK/tROD4jGUyFMGPQ6zeIQCf8eJ4dKglHNAkrfybIG8W48puopl94cp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335030; c=relaxed/simple;
	bh=h6AjxnixN7zryQawdHgJ0ELk9JQuctxNy9yakf7dl/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i2MgObtb9zHvuzmAGyyP2p9VwCn59fxLQQLoGvsMw6CJbYBalUNhc6alZ9ssq7OIFtigJo0tlF9zI2EZbwhBE1CC2P+iYRGPlWYcBpRMcbiHVq1tNRZbObblCIovP9Q+XTm6IVHfp+4l/KGFufIw9lr7QpZnOfq/SEUYa78AD3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IuNSeI85; arc=fail smtp.client-ip=40.93.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IuNSeI85"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raQseEb2PE1xby8v0Vrfb2VhPA/U4PcjEpz3HgnlExr1d0W/185A/x63Rnws2eqGGUuSn3FM6hLiJgSaH//S2DnJIkYgLFBFIJp/ORIbG4gywebKJgi7NP01E0c2a2PzNCOxansl56gFJVqZOpoQsPDu/jD+ZGnDACHMd49Kp9NAvcW6uKnuD2Ua2luGrdWWpfcsQvsRuz3LZiayAYmacyb7rs/PKCigxAPD6YUHDw5w/Y9BmSf1osXkNECqM7vm+e2Mq3VZco3qun/HSrRhwbAAOSeKgRrnXyjuwRnxwg4O+RA5WmH4UrbFX7lpD1ccmnlH9s1vGVieeeqSGnLK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzIqNBfCuk8sPAvBG46IApnefg7ZWRgLxwKatE74410=;
 b=WDlFpt3zXSbiszLxAqWqv7WiAIRCSZDaOV4wH3atJVvRLIkOxx3MbZ27ixBIAzaa4yXxTZUJ4eFyrxH3U1+iSHPmmVGyLpQkjayhHsF38PTDNZbVCJZjuSdrHvpDku5oYxye6BtnOHkoCRZ76BzmxMyW1ZAKtwcEKidElMTIH7YzMLC/grgraa9hT0Kei+iVCdBGUtdM1EI3l2wTNY4OPLO7aCJJNOqGMUU2SWN8SNy4G/vYZbUATqmUE1uRJaRx9AJ5DhUYpQfQYXJ6WYL/xpkehYwKxKJcQGmivJ8kAOzlwSQiKGouUnG+vM24pBGrLm8eloTS29zffPL9MwhvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzIqNBfCuk8sPAvBG46IApnefg7ZWRgLxwKatE74410=;
 b=IuNSeI85+cbn2PAHq5nyDoutdIU89fsLqqEtGL+9ysfD1IEvINWWq1MAlT94tarWX5alcMw9RJmv16vMFMZvtQkUMcN/uKuDvN8s4OC5g1Rdu6wnpHOWZPSLOhmjutXOW3I1ajRAY2ETK5+MgLY7qvmTCINM20sF5r7w8A0lsxA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.19; Fri, 25 Sep 2026 11:17:04 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 11:17:04 +0000
Message-ID: <dc8fdf95-4cca-4dad-bed0-4f7b3c6eb64a@amd.com>
Date: Fri, 25 Sep 2026 12:16:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] sfc: add multipf support
To: Jonathan Cameron <jic23@kernel.org>, alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 ecree.xilinx@gmail.com, icheng@nvidia.com, rafael@kernel.org
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-5-alucerop@amd.com>
 <20260924021535.3e55e8cb@jic23-hlaptop>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260924021535.3e55e8cb@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: a2139c07-849f-43b4-9294-08df1af68701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	oMbcCYPoH6syAakGWaayPC4oATuHm12D5IANJ7KAdsq64HXCWG5sQVW0mNySAm57QNBquof0VU7LeH6ys8oczJAI+Xe8p/speVTUMW8HAMLz9zSC0qiYp7Rvs1jtJ5TKLKVMwlmlMzviQH6CVAs9ZvqDLAa72b4gQlHEeDncj8nTmErUtVVLBGkjr1btV79voG8FG9gTkgH5pXVTx3OJC0TTQirfufV0z1/BcPracLI8LjpmvZ4cXihr+pzKJp6fJYKPRZdP4gEq/T/ArkX0fgTc6nEfaGc1No3Z7J6C1So4s1zpe1kx8YDzURi9z1Zv4i85DUAN5vQVnuz3L5kVOCmsT/ph7Outk8HH1Fo9jGzT/Smj7hVzfvAFnXtCpDcc/qStlB7iMY1lwVtchzvV3rkCKZj6aP842E/oKso9Atb7lB8DJ55DK++S5dMPMxpL3siTTQ+upbtEZOLc7uGfWAwk1HybI0rJmEPMABHB0GungPZ9Qv3k9SvTZ9NbcIHSqkDZecvKG2BMHvt+owc3pSXsVh81MGekEmW/XEbRN1yjG1tNqCPs22y8p4Qo6cG/R6qR9eR/4ySbCYO/HvxxEZNzUL3jZw2kTdE6Ut5uuVDuIgIf010GfZPMKuimqHYP38qotovcYwEMofIyFpE6XQxj5/B6IdnBQ/PVO3mItMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTdQR21LWk42cHFkenk0Z1pWY3VrTGQybEdTOGJ6OTZiQXk4UjFycHh6Y3F4?=
 =?utf-8?B?dHg1algvTEFvaTFvU2xCMmhNOVRsU0JiSkg4UVVNZVZZUDFQUnB3OCs2QTdj?=
 =?utf-8?B?Mmo0RHlzOEo3bWo4am81eXMzckRkTjA5cHJTM2t3ZmltWXpFYS9tc0c2UWRW?=
 =?utf-8?B?QWhxQXdCRXkrbzlVQmU2RWt3UG9IWnhBMzZOMFhjTWg3dnJYVXoxd1ZWZHV0?=
 =?utf-8?B?NzJQSlhGTjRyTEE0ajYwazB3MmtaOVVmWGZZd0ZVeU80N0U1bTBvMFg5SFRm?=
 =?utf-8?B?czIzZU9uQ090L3ZFVDR1cVNwZFpzWnU1S0xQd0RzM1RhcE92L2M2dFo2Nm5t?=
 =?utf-8?B?bC9MOVJnN2grdnJkOHdTNGx1U09HZlZockZOWmZ0WkNQSlBza0F2SkYzQnFt?=
 =?utf-8?B?azlocmRXdU5QcGxYeXQveVRxdU9LOUt4bk9QRTV1elFWemhwQmdkZWkrNUhN?=
 =?utf-8?B?WDcyZjg0Q0FxU0t4aDRnSkpzM1VyRlhzZTRuM0s0MytUdm9yaUMzMldramdG?=
 =?utf-8?B?VEd0cGI0SXU2MCtJclR4ZXJKYjBDV2Fxa2JDSkcweDRXTmgza01ta1RuYm4r?=
 =?utf-8?B?T2NMZFZDUTZPVnlCRXIxakFINFhyZS83Q0ZWb1BtWGhLeXpPQkRJMzJidUFz?=
 =?utf-8?B?UStjS2k3VHZuZzdFR1ZzTkJGYzRLempGaHlKU2I2UnoxUkZ1MTQzOXpqbWZ1?=
 =?utf-8?B?bDNjalhBWCszenROTmRWWDh5bUsyREptNWxjUnA1bTIraHhqTGhRTXhmVlRP?=
 =?utf-8?B?dEt0RGdnTW5xQ28vWldkZ3FyN1JMcmoyTk5PYUt3Yi9wOEpUd0VCRmdQV3RD?=
 =?utf-8?B?V1lkNkVBdDNGZjF0c08wZkJ5U3dyUUtHNmQ4Y0VTVXNsRVhhQ0dxbDN2RGFX?=
 =?utf-8?B?a25YeXB5WkdRTEZsWk92SFNMUU11aWMvY3BWTFdNcmQyZVc2ZDFOelI4NzFk?=
 =?utf-8?B?alRoWTVHaFNlT0N4bjZEYStiVmlDekRMMDJ2aFNzMzFua0o2cHJyR0lxQVJk?=
 =?utf-8?B?eXBTZzZnaHB5dTArZ2JHMld4Q0pBeVV4NXBRNnVPRXphR3JyR0V5YURTSHdl?=
 =?utf-8?B?MWMyRE9xVnV3anhkV25BdVFTTVNLT2V2UU84YldHUGJNcE93N1Nrc1JHbU9H?=
 =?utf-8?B?SmRXMHRXTHFFMlZtbllTTlVqMmVaaFArM3Yvd1luaW9JWFh2UWlzbEJaVm9N?=
 =?utf-8?B?RCtyRFdwUzA5YWdhWHFJRXc0L0dxRWF0REN1T3RqUkJ0RndVbzlNV3QrN3lj?=
 =?utf-8?B?aUpuQUpGbUF3MFBTa05qanhORkRaaU1wb2dKWnZUYUVMUk5zT29GbCtqdU9i?=
 =?utf-8?B?OUlhL2h2S2VCbDQ4blNEUWRTTVVaR01FR1F1V3lMOXhVS2xTVGdnTTI2dUJT?=
 =?utf-8?B?M25zYmJhNHBJWEQ2NGJJWnE1emJpdzRqUzVoT1ZHQUhaMmh3R2lrSE9FRmNT?=
 =?utf-8?B?K2ZMc2FCMTNubjNTb3ZZYVhhSlN1RWZ2NzFzSXhnUFdTdHJVcmZZSm9MRGhP?=
 =?utf-8?B?RGY3STh3UVhqTUhFN2dhaUMrNVRyejd4eStZN0s0UTQrVzRWdGxTRHM1dmpM?=
 =?utf-8?B?Qjcrb0tyczZpMk1iVjFRcCs0UzltLy9jWStOMjl5R2MyZERhUmFOY3ZUdWVK?=
 =?utf-8?B?eGpYSWpYR05IT1IvaVNEQzVSdUlEaFZrVW5zM0Q2aDlxeTJRaW1QMWZxaENN?=
 =?utf-8?B?bjFVdzZieDRvYmJNRU11aEhJNEpIMzdKL2JydTdYR3RFQS9kbHBVeXVIcE5U?=
 =?utf-8?B?QTM5WG5aNWhNNEE2UExacUJIN1ZhdjlRbzFmYVBlUk52RnpxZitKeTZYL2Zr?=
 =?utf-8?B?V0dXWFkzWmQ2a1NvSlFhZndZM2Q3REx4Y1pSRnNESWJMSTBhamF2M3RDcUlU?=
 =?utf-8?B?QmRUM3BYenZVWlZDeFV4UmREVVdJZHVlZlRXaFQ3S1NCWnJrcmo0dk4rbXRt?=
 =?utf-8?B?eitMSG9talBSdWVRVkgzNS8wMEg1S1N3MlhRL203YlpabUlTb2JkZnU0eTdy?=
 =?utf-8?B?RkU3ekVPdU16d3hsMk9HSHhITm1BWUZtUTlIcHhEdUVjT1VydlNQNTlXZzVh?=
 =?utf-8?B?ZEJlTm5pbUYzZlVyNkNKYnF0cTJwQlBPeHl2ZEZjYjdyZmFIbHdUYitNVS9Y?=
 =?utf-8?B?ajRTY04veDFmQTZlaGppN2g2akJ6NXhwa1dhL0tVSEpoU2ZZb1dXNlB0MDZM?=
 =?utf-8?B?MTVqVndSc2JGa2JNbFNZSUx6dHArSlVFRlMzeC9Dd1A3aDdiT2pBN2Z2Wlh5?=
 =?utf-8?B?ZUlSZStiajBYVDJlRm5MN3dRY0p3WVYvRGllR2JnOEJxQWhDMXJSUkhRZGJn?=
 =?utf-8?Q?Uyx1yB0BdrfhMIBeMG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2139c07-849f-43b4-9294-08df1af68701
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:17:04.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIumlVa7ECHXHZEMK324SCgXK6vVOq+hQNQQDLa1UJ9hMimbvVh0k6E9KzgsOVvB4FInH6hS9Td4w35yTZ5JxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677


On 24/09/2026 02:15, Jonathan Cameron wrote:
> On Mon, 21 Sep 2026 20:12:39 +0100
> <alucerop@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use CXL core accelerator API for registering non-PF0 PFs to the memdev
>> linked to the PF0, along with its complementary unregister.
>>
>> Adapt the ioremap call per PF to be an offset based on the PF function
>> index and a hardcoded per PF CXL.mem slot size.
> I was wondering how you'd know what memory belonged to which one!
> Simple solutions work best I suppose :)


Hi Jonathan,


Yes, I think nowadays it is simple. I'm afraid if CXL usage increases 
this will require some request to the firmware ... which could depend on 
previous setting requests to that same firmware through fwctl.


>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 75 ++++++++++++++++++++++++++----
>>   1 file changed, 66 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 348d7404cd7a..bed8d9c59185 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -13,6 +13,31 @@
>>   #include "efx_cxl.h"
>>   
>>   #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>> +#define EFX_CTPIO_BUFFER_PER_PF_SIZE	SZ_8M
>> +
>> +static int cxl_map(struct efx_probe_data *probe_data, struct efx_cxl *cxl,
>> +		   u64 devfn, struct range cxl_pio_range)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	u64 cxl_pio_pf_start;
>> +
>> +	cxl_pio_pf_start = cxl_pio_range.start + devfn *
>> +			   EFX_CTPIO_BUFFER_PER_PF_SIZE;
> Wrap as per operator precedence as easier to read.
>
> 			   cxl_pio_range.start +
> 			   devfn * EFX_CTPIO_BUFFER_PER_SIZE;


OK


>> +
>> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_pf_start,
>> +				    EFX_CTPIO_BUFFER_PER_PF_SIZE);
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>> +			&cxl_pio_range);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	probe_data->cxl = cxl;
>> +	probe_data->cxl_pio_initialised = true;
> 'map' is carry quite a lot here that isn't really about mapping anything.
> Maybe think a bit more on the naming?


Not sure I understand your complain as ioremap is being invoked here. 
Maybe cxl_iomap or sfc_cxl_iomap as this is a static/local function 
would address your concern?


>> +
>> +	return 0;
>> +}
>>   
>>   int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>> @@ -21,8 +46,48 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct range cxl_pio_range;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>> +	u8 devfn;
>>   	int rc;
>>   
>> +	if (efx->type->is_vf)
>> +		return 0;
>> +
>> +	/* are we PF0? */
> First things we ask seems to be Are we not PF0?


Yeah. I will change that.


>> +	devfn = PCI_FUNC(pci_dev->devfn);
>> +	if (devfn != 0) {
> I'd factor this lot out as a helper to slightly improve readability.
> Perhaps factor out both paths and then have an if else.


Yes, I think this makes sense.


>
>> +		struct pci_dev *pf0_pci_dev;
>> +		struct cxl_memdev *cxlmd;
>> +
>> +		pf0_pci_dev = pci_get_slot(pci_dev->bus,
>> +					   PCI_DEVFN(PCI_SLOT(pci_dev->devfn),
>> +						     0));
>> +		/* This should not happen! */
>> +		if (!pf0_pci_dev)
>> +			return 0;
>> +
>> +		/* Is the PF0 device configured with and using CXL? */
>> +		if (!pcie_is_cxl(pf0_pci_dev))
>> +			return 0;
>> +
>> +		cxlmd = cxl_get_pf0_memdev(&pf0_pci_dev->dev, &pci_dev->dev,
>> +					   &cxl_pio_range);
>> +
>> +		if (IS_ERR(cxlmd))
>> +			return -EPROBE_DEFER;
>> +
>> +		cxl = kzalloc_obj(*cxl, GFP_KERNEL);
>> +		if (!cxl)
>> +			return -ENOMEM;
>> +
>> +		cxl->cxlmd = cxlmd;
>> +
>> +		if (!cxl_map(probe_data, cxl, (u64)devfn, cxl_pio_range)) {
>> +			kfree(cxl);
>> +			return -ENOMEM;
> ENOMEM for a map failure? Seems a little odd but if there is precedence
> fair enough.


Confused here. I can see ENOMEM being a common error if ioremap fails 
through the kernel. Maybe this related to your previous concern about 
the function naming, but cxl_map can only fail in one way and that being 
not different to an ioremap failure.


Thanks,

Alejandro


>> +		}
>> +		return 0;
>> +	}
>> +
>>   	/* Is the device configured with and using CXL? */
>>   	if (!pcie_is_cxl(pci_dev))
>>   		return 0;
>> @@ -80,16 +145,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> -	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
>> -				    range_len(&cxl_pio_range));
>> -	if (!cxl->ctpio_cxl) {
>> -		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>> -			&cxl_pio_range);
>> +	if (!cxl_map(probe_data, cxl, 0, cxl_pio_range))
>>   		return -ENOMEM;
>> -	}
>> -
>> -	probe_data->cxl_pio_initialised = true;
>> -	probe_data->cxl = cxl;
>>   
>>   	return 0;
>>   }
