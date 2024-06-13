Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB31428FC
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279163; cv=fail; b=nP/2/gnBStYWyn6dbDRXkot0Eytd3vOmXjOEj87QaYEcTqVgJpPC6Pq51pBhRFzfi09T6rddd+aNd1xh8QyS82cdfbEfRjSWH9DbQ2Evphj5gHV9PU8jDt5hkQalXcia1dX5UI2NfL+1Yk3XcD6LZnp071WtbohSw5J2INJJPA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279163; c=relaxed/simple;
	bh=p75v3QFUZyEYqd/PyUkl69Eayb1tVDaeha5THlmlgv0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QIOKBEI0RPD7WrKcY9FaGHI83OyR1V0GoYekPDCrN/NnSghFX4F0Zq1UxO6dF71DIrV5oX/bJLdzNJJFdmrons/dVc8zBjesgCISBloDXez9FsMZc1FcYWe4gPkAbdukj3yrlAMZHuFGpwqcllCA9ciF64Hmh9ZJgfdDNs5mTVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3WmocXAr; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3WmocXAr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw5MlvSbaiJYD+oPcDNH209QFoLKecKrPVQFeqmt+DjyNk8dSIuHSa44kvsh9Xz57rYnp6bK3CrEqaKu/T6WwIS1DlC79QRMHyVe3NVwTS0xFkHfzSjSeI0G95zmnLuREHeNXnEaEnLybY12ZWzxfarOodqvijfWh4QU6Tqf+6nfipEcPzlOmFtt3d7rOALXxum+ssfhXXfQ5t/LE34OMynIIKG11G7wWL+UvtB+oN1V9feEEWF9HOYODekvTi8Y+KjFHJ5YzUFY81E6pJ3I3PtEsBC4wAkYsp1tZsTjOb9rgJN0PTDKrMaLquJmLBZYR+/DWoRT1VQSv0piY/zWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J38qNYmehtpJm6C3Hec3ySo7U+feyRmuulzjEQ7WvJ4=;
 b=JHdSGkh7GRX6mSzpTF30j404lhGanKY6xcWQ8YqyCPBOdrI1lAQq+5lhRjytKkQcrgJxArnSlx1IY02GqLeyENEhhOXFZWSiG5z0hH4ZDGqr57YXXkDBR6W+Q8Atjqe72TmdkmjDQjhcWGv1uDrb6h2isJns2FN61kew/QoSu5X6LY+LeGAAdA5ztv+ahiyO1i3+kajDyVMFR0aQSpXxaMiaO5bP8P9rWUkMJ3WvhArShU67nvXMteDu3aS+iqimChdzHG7tQrJqKkCCONVRDaRqcsD7HiAqiY/G3xUcAKfNdVuR9VWwyv7oWvrWuF8AdbrsWnlT+XQT6rEmbSvphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J38qNYmehtpJm6C3Hec3ySo7U+feyRmuulzjEQ7WvJ4=;
 b=3WmocXArxDUEzMcFCJ0ocGAFacY45mUuLpu3VXG13jTKjxCxdn2mzYxRqJ6ES1T8ZY4AmLs0vERlKCkpVl0E+WFePDHGrcxV7TOUtWH+xwAIgGXdmRwArf/vNu8aQZLHukzxQSuToOG94qPNuR+hD+7xfOrhvQQ44LuJHl/A2Os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 11:45:58 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 11:45:58 +0000
Message-ID: <b51be5ca-cf7e-bd93-108f-1713e04301c3@amd.com>
Date: Thu, 13 Jun 2024 12:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 01/13] cxl: move header files for absolute references
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-cxl@vger.kernel.org, pieter.jansen-van-vuuren@amd.com,
 richard.hughes@amd.com, dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-2-alucerop@amd.com>
 <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
 <ZmkkaOTUFuzIr2cG@infradead.org>
 <666a1099c94e6_1fcf294e9@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <666a1099c94e6_1fcf294e9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0541.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b481a2e-e8f8-407b-ed40-08dc8b9e63f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|366010|376008|1800799018;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1pZbDZGTVFKcUdJb05vTEt4dW0raWZYSlRZSkQrVHZWZ1lUZno4emNIczIx?=
 =?utf-8?B?aG8yRXF3cHl0cWQ3MEprdW9ZVE9ndUFBMmNEeGZWcUJCOVNnK3JXYzhaT05u?=
 =?utf-8?B?LzIxaGpmM1paWWY2N2ZWcndzRFBmcDlnbGh6aDkxMUtmOEFRMVpTVWh6Ni9y?=
 =?utf-8?B?ZEhzNjJDUUZqVUpMZGc5ckZLMnMvTSt4UzFHajdkVm42L0xNdSsyNkVPb0RV?=
 =?utf-8?B?SEdQblFWZ1FTUytZUkdpeUdKRzBNTWFyU21tU0EyMzZVYXBCQ1UweDBNc2JR?=
 =?utf-8?B?MDFOc2F1ck5WODVjaHBSK0loVlZqYTRsQVdEeTRTTTJUcFRpcENBaEQwWnBo?=
 =?utf-8?B?TWpJVUxOU1M2c0NaTzBqSmE5UkhLVVFvSVdTYjBPRkQ0R2hiTU1XNFRTcTY4?=
 =?utf-8?B?NlhzNzFweGlhb2NkSk1GdVpEMHhveng3d3dVYTNNOGgrUXNSS2doSUludEx0?=
 =?utf-8?B?dWhuRmh2ek9VQ2hob21FTjZ0czI1V1B2eXd3c3BycjBBSWVSS1dHLzd2dk4v?=
 =?utf-8?B?OC8wdU1oaDE1TzUxM09rSWpVQUtmdDh2UTYydUlTcWtvYmRnbmo2ZmJaYkpu?=
 =?utf-8?B?N01JQmNOYWF3OUVnWDhNQkFBQ0s5WlFURjc1Y0t5U3BJMUtwdHlsU0pYenUr?=
 =?utf-8?B?czFTQXVjaS9BOHdZUGFOU01TcytsdGczR3dLTnlSZy9meXAzZVZFTmUyZ01T?=
 =?utf-8?B?NUorMWlPQVNyUFo1a1RON3M0aVVsR2VueHVFcEVPanhWclR3em1Gc1EwenUz?=
 =?utf-8?B?aVc5bnErWXJJVVgxdWdveDdHdVRMbVJRb0J6Z0l2aVNGQXBzWjI5WXppNGsy?=
 =?utf-8?B?S29BazNpODRQaXNlU1pCQTRMV201MUZveUhlTFFGZGhtbmlGcEE5N2NuNEZ4?=
 =?utf-8?B?V0dQMVcvSUtQaG8zdVd6M1JSRmFTZG92eTlnNWFXZUd4QUNLa0tCVmpjQ1JC?=
 =?utf-8?B?S2ZNVFhFZWtld0VHTXFLa0xpSUE5V2IxTjBnWUlhbTIwbVdHYVNES2Z2N0JQ?=
 =?utf-8?B?SUVyUUlIc3dadmtMbktpalpoeFNjZnJlZG1hVDF1bVhFbW8xK3FISCtRUUJX?=
 =?utf-8?B?OUcrcllJaUtpdHFVWVB4OTdZbTFxN05raUoyeTRWZGkwUUNtY0FldE5zQ0Yv?=
 =?utf-8?B?UmorR3k2TE1SMnFWR05wUlVvV1lUS3BLaXB0K2lQRjlHVGVrQXprWkhvajdN?=
 =?utf-8?B?dXJhdDhIdGtZUW10TUt3bjdQNTkrNnlHdlJINXhYa1E4TlV1cEgvTUtOb0hn?=
 =?utf-8?B?bFY2OWk5SFcramZ3MkRyZXgxbEU4Tjh1b3pFK0JiZ3FCTVRmMzNsUDJVN3FT?=
 =?utf-8?B?Y1dwTmRKcmhqUjVRcWtiZk04RG9iOUJsdzFPZGlySkdSeFEyaGJCa2hHZzNW?=
 =?utf-8?B?Z0d4S0tUN1l1MURIYVBDR1V0UGh2a2ppdityUjY2bGhpYlNGNHQ5SUFuNnY1?=
 =?utf-8?B?b1hFbmlUem04WUV3cUhnTVRqaUQ5MVRTTnc0MTNwaDRuYXhvL0ZraDFKNVRq?=
 =?utf-8?B?cWpNZWwxWFNGSis3QXVQUUIrc0lUQnZaYjJmMnprNmhDWmNEUk8vcVk2UWcr?=
 =?utf-8?B?cnJYcjRzb0tWK0l2UzFlSktkSVB5WWIxUnV6UFhYakQ2R2RyRnBwdGE4MGVL?=
 =?utf-8?B?RURSeThsRThoN0xSUnNKNzQ5S1ZtSGRVT3RkVTIrMFlYbnppc3JTZitRc04v?=
 =?utf-8?B?VGpDVXdGRlZnVHNTOWtGS05oUkd3OTRBR1ZwcHVMczU0OEN6dHRUQndETFY0?=
 =?utf-8?Q?UENTq0O+3Vc/MQAh3514H10JSUfH1/I1xef9EtT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFE0bzNpVlJXTVBibk00VFlFK0NxZVJDZlJmRms1T1V1S1BvMTNldGJ4Vkg1?=
 =?utf-8?B?K1ZjUVNDRld3VSs5U0o4SVIwVGZzbWdZbjNZS3FrYkx0aEtvN0N6dU5rUWRr?=
 =?utf-8?B?MFl3SzBidVBuajZaR1pxcXduRGlmVVc2VlBzRU9zeWIweGcrZzUvZjlTeG55?=
 =?utf-8?B?L2REb2xzV3hLR0JUQlJyOS9Jd0s3aDZNTjd3WUtnbHJZUFVpek0zMVhyQnpt?=
 =?utf-8?B?TTVlRUtNWU1jMXd5bElpcXBWcHFLUW5YNTh5UTAyZFB5bThPbTJxRmZUV3pL?=
 =?utf-8?B?dmQ1RzQ1cm1xZ1laZ0FVQis5V0pyOU9Vc0tYUXhyclNYZUh5d1JDRkZPOWhv?=
 =?utf-8?B?cXhRM29BQTgwaFRQNUFkd2VvMzhFczNCUWo3ZDdhMFpxOXZSTXFPREd0WjRF?=
 =?utf-8?B?YTNLSlpRcVhmMzkxWGhxMmcwdlA4cGZpV3RlQ3pESm9xWk9tTEd5N0R2OWVT?=
 =?utf-8?B?RzVuUTM0KzFsNE9kcTl4MlQ1eWxQWWIwV3MyWlJrdGVIQmpvRjl2M1NYK3hE?=
 =?utf-8?B?UDFkUXRBbUoyeTRKSDJqZ3BhQ25VbVh1N0htVVYzMHhza09HMHVpYk5SMDAx?=
 =?utf-8?B?YkNQRit2UXpHRGxFU1UzSW1XeWlGMEVPVVpIRjg4bndxSzR1VGVQd1NDK1ov?=
 =?utf-8?B?bzYvc0k5VjJxaCt1Q0NFdUZWQVdieVIrMWc5alAxQzRSVURlYmd2Y3NySnZZ?=
 =?utf-8?B?QS9JbVB1UVYrdHR5am5zK1hsRklsNHlhRGlzY1hocFdqdkQ2T3RsR1ZHR0x0?=
 =?utf-8?B?T09yWVJVTzdFTURzbzB0VHJjWFdneGorRGViaXA2Z3BwYzkyUjIyUHZPcEU3?=
 =?utf-8?B?dFhJMkhPZWp6L3kwRVFxVGc4L3h3Z0NyWDFtcThMNUJIRWErQ1FrVXNUUjZi?=
 =?utf-8?B?ZmUwQjh5R1UyZGdzbEpaR3FVWjNyZU5YWEcxM0lCU2hERFpnTTQ3amNTelFX?=
 =?utf-8?B?dXdwOVV4RjZteTY0RjhSR3NJVnpJQXNUSWxKUW1NR1lBUnhQQ1Q2NXpMUVVV?=
 =?utf-8?B?OFl6cGQvbWVNS1R5ZXc5OGJuUFNWZE54SlM2My8waEo3VU1KcFE0UVczOVFW?=
 =?utf-8?B?VTR1TEZhNDZxMWw1cytqYkllVncrZWdtdE1FVGUvSHMvTGdwRHk2VDJDRXYr?=
 =?utf-8?B?VUxBYk0vVzhsbjZ1MWlsODd0RHhDNjZwQVc2N2RQM0hRck12elp6ejhJWStM?=
 =?utf-8?B?aGdhNTYzVDhIdTkzSHRvc3lmejdlMXBzbG41dXB2U1pXaVJCaXZHb2Vkd1hp?=
 =?utf-8?B?T29IUm1mZXd5Qk9pUkp6TlFCeWk4VXNZdy9hRmdjU3QvSHhFR0FRZExLaU5r?=
 =?utf-8?B?MGRrWnMwYnZ5azN3WkNzRXZELzhHcnVwVERKV3FFd2szUWt4c2xQZUZhOWJN?=
 =?utf-8?B?cXY1S2JoYWZoSVhOWWZDNEZaODd4YlV2WEFpS1VsZ0pOZExTNmRrd2FXUXdJ?=
 =?utf-8?B?S2U4MzFXbHlIdVE3QVNLL0FGMXdjTWFENUpNaStXZDFDL0xTQUZZVmdCR1dr?=
 =?utf-8?B?N1JCNmlmY3p2dGtGWEQ5ZVFRbFR0a3A2cytZS1VGbWZHUmp5ejc1UHR6S2tO?=
 =?utf-8?B?ZU96QXBlbUJ2MnYyaXFjZzExOXM1aWdMcFRYdlVnQlNXTXQvb1VJWFRHRzc3?=
 =?utf-8?B?cmpJZG9YTEtSOE8xNzF4ZDA2blRVQXl0dVR5MzF3YXVaWXFyV0ZFMmdQRW05?=
 =?utf-8?B?dDl6SGoxMng0b21xdnB1dERWZ2dIT0p1VEhDcDQ1aVVaY3RQL05CTDdEYWlk?=
 =?utf-8?B?UG04Sk9zSm8yNWlkbGQ4ZzZiWlppQ3hiQlVjVXp0cDQwajROVEtBUTIrTzVx?=
 =?utf-8?B?bXIyd2JmQytrait4REJtRFFlQjFJVmF4Zm1QQzA4cHkyandsT0ZEbnpSNllX?=
 =?utf-8?B?Ujg3UERvZ1hnL1JYTUpUdG1kdFUvUi80ajJ1Y1hGeDlROTNPTU1WNEtjeVZr?=
 =?utf-8?B?SDE3WXpnUHFKcytRYmF4U1I3enY0Y3hPbk5yQjJ6aWprTTlIaVR0RkRtdVdy?=
 =?utf-8?B?TlNJclRBMjhUMVYyTUJKdVhLSnVuV3ZUUVhUN2ZFTDNoT1VxbTRYNlUrRmVI?=
 =?utf-8?B?NW9mOUYvY3FObkI5Sk5menFYcHJ2UXkvQjFMVzhIeFFKdmZibGJiajdYVG9j?=
 =?utf-8?Q?zWXQF8P49WLZRrv0TGZxY9bcx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b481a2e-e8f8-407b-ed40-08dc8b9e63f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 11:45:58.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4E1WCzhZwLmZE3aRk115mrG0ycyAaYyLT0ZC5/7FLDWAN1Q6e4sBDORIFBnSocuasUAJeKfCle2NFLLkXyR45A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805


On 6/12/24 22:18, Dan Williams wrote:
> Christoph Hellwig wrote:
>> On Tue, Jun 11, 2024 at 09:27:38PM -0700, Dan Williams wrote:
>>> alucerop@ wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> CXL Type 2 devices imply specific vendor drivers binding to those
>>>> devices instead of generic ones offered by CXL core like the PCI driver.
>> No, it absolutelt does not.  There is no such thing as a vendor driver
>> in Linux.
>>
>>> So I don't like this approach, there are details that are private to the
>>> CXL generic memory-expander use case, and some that are suitable for
>>> CXL.mem and CXL.cache capabilities in other drivers. That distinct
>>> subset should move to include/linux/. I.e. I want to see the incremental
>>> conversion of what 3rd party drivers need compared to the generic
>>> expander case, and consider when and where new shared infrastructure
>>> needs to be refactored.
>> And I'd much rather keep all these drivers in drivers/cxl/ anyway so
>> that we can keep a tight control over them.
> Yeah, especially for the common pieces like CXL memory where the
> endpoint driver is responsible for registering a 'struct cxl_memdev' and
> the existing 'cxl_mem' driver just grows to accommodate device-memory
> alongside host-only memory expansion.
>
> For CXL accelerator use case that's where more specifics are needed
> because CXL.cache operation gets entangled with IOMMU / DMA mapping
> policy for ATS.

I think we all agree the central pieces should be in CXL core and other 
drivers requiring CXL setup going through such central management.

But this can be implemented as I thought and tried, and Jonathan has 
also suggested, that is an API with opaque structs, or through a more 
disjointed way from a client/driver perspective using an approach like 
auxbus. Maybe there is another approach for "keep all these drivers in 
drivers/cxl/ anyway so that we can keep a tight control over them" which 
needs to be more explicitly elaborated.

My plan is for a v2 removing the test/mock driver and adding the sfc 
driver as a client, but only if the original approach with the CXL core 
exporting functions is the approved one. If auxbus or other way is the 
way to go, it will be just a new patchset and requiring more time.


