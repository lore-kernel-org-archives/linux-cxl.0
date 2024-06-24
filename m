Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399E1D53C;
	Mon, 24 Jun 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244437; cv=fail; b=aTWiPWEwJgWhEw8Xd53J+cTj5miMeGEGxNmE5CofmfOVqJogXfyGboUjw8QCSXqcNsTNMt3xOZn4svM6CTBofGTCP4OQnso4+UOxSKqnDRYzR9lyjwoYrgfZ+ZAgV0JNnwY6MsL8coLSx+u8rwpIW/nKM0sFxm83MAWAPvFFI0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244437; c=relaxed/simple;
	bh=9YOsG73OstpEgpH/9Ma54NM4OdNckKK3yvjZBZOc2LQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i8ole5HlTvgg8wn1fQdlqTpie5Itz/TM1P2+G+pE8loKTnUo73RTVHUaLvtspfDj5mmRVN+OGd+mVYoddkxl2jZ0t16VqyoVfchXws58e5H5fR4dUxhXqYLgPX1zK7/w+50LINkgXesnnhy2kbJaHPu37f8x7iHJZiSERwzcqTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cWCXHnyC; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cWCXHnyC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eL1ubTS+f/Srn6rXxzTL50VKnA9pqWABjWXGc04h9wmqgB5vNDodccQSixL9CDKJaoNgT3R70R/vmYv+D/Xfps6Cn5urF6pjsw+WyV7+PdrFeh/DPCe7rQCxSgLQgomBVtsp6ulwHzWgFzIXeXrTSfKat9eWMZYTqgfnvqXyNdLMetxyxK2N4lY20n2V/ZSY72YXNoNvrbMkheXGhIBtxVK6kAcaGAf8YCXEt/CT4loiP2tR3G+MIT8HRmldTLDdieFk2cAW3q6MlXJn7XUshNcHZErZP625S42xv6IszDYcPuEunxZ9kNQHOUOLIQDFd+O3O43Wo0894y/LjoUUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpRiwakasfPGAZ6wtzhJZsti36GP69Yf1VeRKJKbHJk=;
 b=WDNk09xHLtOwS1t2PH/U6yzRO13fJ3Nfx6fOcWpin2U0XqxPMfVPL9Nj1U8c1bumaWvYtmtL2v/Mp1n+3CRjqoym2KKd7Rhom7rThZ0+raqnpxpbPW0E719Wo78KxboZ4nQoSrrGPB+8X7AFb5FI3J0FN6yFcYP09lYAEvzcmqsHCSCFSfEQfL5S46WvsBhM6guMn26qDhm7T9ipKL/7h95QGNzQzvHIRfxBTwc9WRnhppCyUnHafuNGfhElj2LywY/tOAw+deCwkwrDKKt0IuYKNF78vYbeAOzF8QDXFLh0YUnz2LGdsjXwbzA56mZ43JRRmsdMq4ZD5A3hg9yCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpRiwakasfPGAZ6wtzhJZsti36GP69Yf1VeRKJKbHJk=;
 b=cWCXHnyC4u82w0qdKdaw4g7Pvdb545DMZDjp9bHSn7cMh/tnO48evAlhWbb3SSxgjGvFPbZ4ZqtO26VjExmKwRw0OMjPobXZu+ZQFJriGnEZhiwwu6P4npbnNoD7Jwq10LgNKms0MC74h1psrCK4mCD6S2btsCAyN0h+7vFqH60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 15:53:53 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:53:53 +0000
Message-ID: <550358f7-66d0-441c-abd9-f8edce9a5eb1@amd.com>
Date: Mon, 24 Jun 2024 10:53:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/9] cxl/pci: Add trace logging for CXL PCIe port RAS
 errors
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, ming4.li@intel.com,
 vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-7-terry.bowman@amd.com>
 <20240620135332.000053f5@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240620135332.000053f5@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0089.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::19) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4ae8e0-e056-4830-cbe0-08dc9465d8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2dkQ3B0U2xCTTBlVmtkYW9FMk1wVVJzQy9YYzh0d3RMeG5hdEM4RU5ZYWxL?=
 =?utf-8?B?U3hjVXNZajNTbmswZStHcnhmeHF3b2RFZEIzckFBODRkRFJOZ1hUbCtUSmF4?=
 =?utf-8?B?bG1Jc1RHQUtXNmlRbEdIRmtPbmQ3YnVVMkxMdExCdFdCWFR0LzJIUjdkUTkw?=
 =?utf-8?B?bXdZdG1oMjFRVkdVZ2QzeG5ZNHhUZmZoT1lhdUN6RGJuSnFnRDc3aXpndFQ0?=
 =?utf-8?B?RWF4MUhQR3BDc0JqK2NOc0VUbDN5TTI0OWF2MVUzNEFGb2dlVGRCTEo1N3BT?=
 =?utf-8?B?S0hMR3Z3S3FyT2JqVHBHdVpxZ0xtWDdjOFZNS1JnRFNiVDVHaEdvdEMxNi9p?=
 =?utf-8?B?YUFmbGhjcys0YWVYendxYzFGb0dHTFNsSXNaaXlqaG8xVDRLZmtlcnZuVU01?=
 =?utf-8?B?NDA2c2VKSC9WUjRWK3c2dDJQNXZRd3k0NjRHNnNwNXBRUGR6TFZNWkJ4blJz?=
 =?utf-8?B?MC92ajRpaWlFL1dwVkRzZFRrK1FVd1B2bGtYR2Joay9zbndhZW1VcXloaTFo?=
 =?utf-8?B?ZHJ5dlZvV01YRDlBcDdMbzNpOHlZSWUybEp6b2N6bUw4b1drOFdwVk1UQUpU?=
 =?utf-8?B?SkMrOFZQcGxvTjRGTXFvemkrYWg3blg5cmxSRHVwUGRWblNRYmNmOFAyZHJy?=
 =?utf-8?B?WXp3bjdmN1ZGRFVmVDZPc3lvbERSTEoxckd4Y0dvWXBqZXNYQ1NiMG5ZbU5R?=
 =?utf-8?B?blFXMUM3NEpVYnNrdWtIZzltWEZkWHBsM2RVUXpabVZvclFFOWNGTzBDZVpm?=
 =?utf-8?B?ODVYZGN0bGJIQzJCWWc0ZDFQSUgrMkh3VStLUUs0aURFRHZWSlAwWExZSkRS?=
 =?utf-8?B?MkJHSlRIYWZyNEJ3NVdhVHdkcVVjamhQdE5wV0pkU0JCbndMMTg0SUUrem1U?=
 =?utf-8?B?c0d0Vk9Pd3hwN1dEeXVxOVluYXlJSDU5Z1RBN1Q2ME1kdEw4TVBRMUJpWDZU?=
 =?utf-8?B?OXpTbHN3VjdsVEs0dGZQZ3ZzN3F1ZlZDSmFvYmlOTUtGYmFYb0FsTENEQmhp?=
 =?utf-8?B?ZjZMVW9QNEVCNHhLY2wxN2pwaFA3bXR1Y1hYMG42YlAyd0hDNkVhWGRWNEc1?=
 =?utf-8?B?cHZpdVZMdUM4d1Q5Z3BocHQ4M1RiMHFGQzdBdFcyS0Nlb2pSV1pyVXJMelJH?=
 =?utf-8?B?N21BYWxtbWhaQVlqV2JPcjQ2bUJYdThKOTQvb0gvK1FhREtEZEZ2bkdJSWo2?=
 =?utf-8?B?b3pKTDh1UnFieDM4VTBoTlI4NUJZTXdVUWhPZXh4TEhDeG94eFI3NHJIVk01?=
 =?utf-8?B?alcxRWZ3RytjeDk4eGI0REEreGJkRDRySGZjNTY0SGJYVTZyZ1kxb2pJRG9r?=
 =?utf-8?B?c0ExbmxwVVBRK0lUNy9GTVVNdDM2bHNXT0c4MVFtOUh5Z2xrZWNvc3pZdnAv?=
 =?utf-8?B?VUJrMDNSaiszNzlRWndSRHZmTWFmM291ZGdyZkxYVHpOcFA4TmNDVTJ6OW5I?=
 =?utf-8?B?b1lEUFdEWkxRb3VSRDZhSHNjWjI0SnJhWDd0UWQ1NkFDOHc1aUJNS0xxbXZ5?=
 =?utf-8?B?S0VlVWw5UGlFU0pIN2hJbytieVNnWFl3UG9kQUh1aWhveUEyaVJzTGZNdy9t?=
 =?utf-8?B?dDlVYVR3WGhhRU9kdnRFa2piQjFGaGQrWUgzK0dRKzM1ZGxPVEJwQ0JJSmQz?=
 =?utf-8?B?QnhzczhZNC9GZTZIT29zN2txNmVmZjUzaHNvZWd4Nng1UncwU0VKNGtpSUxS?=
 =?utf-8?B?bHgvalQ4WlZ5RTJnZUViY1hSN25JZ0lEQWRBN0xLK0l4dFl3a25sNzg0QUt6?=
 =?utf-8?Q?mo7tYS6FJU3GJ9lSgGjVi7q4GMSFK07E6W4Uz5O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzZ1cVVLcm0rU2ZZUnczMERldHVEbitrMnlEb3JNdUxQUDRrM2lacTNJT2NO?=
 =?utf-8?B?QTlJcU5VeHBtQXJlZ0JSWFNSN3AzdmZmV0wxS2xRaTA4UnNScUJOV0lLM0g0?=
 =?utf-8?B?em9TVHNvM3ZUbXJJMFlnQys3UDJKaFRkSHJYSEtQTHdFWTFqc1lCZmlsWWIy?=
 =?utf-8?B?NFB5Y2tUZVE2K1A3WXJvQ0RaSFVZSXhmdy9iL1BQODZ1OVUyb3poemVZNHgx?=
 =?utf-8?B?S3dCYk1wY0FUVEt4ZzlDMXZ6aGcrVzUvamlwZXJXV0ZYVVBUaSsrSVhoaDBQ?=
 =?utf-8?B?RGp2Ny9SYW1GSitoTEQrSFJlMkhiL3ZybElEdlR5cnlhT1FwcnIvTmhaZ3B5?=
 =?utf-8?B?YVVQaXM3MC93NnZSTjBpejN2dFZrR2JsR040TjFvL3hZUUFTaS9iMHJ2Tnc0?=
 =?utf-8?B?SGdWWjg5ODNiRWRBbW80dkhqYnU2ajhmbGZ0SldYVUJoejFraHliZUQzVXZE?=
 =?utf-8?B?ZjkrMG9teC9UVVk3YVV0UENWRGxPRlE3MXJyQWhKQnY3MUsxaW9VYm82S1Ba?=
 =?utf-8?B?a1doV0lYQ3c1Y2ZwaGJKRmZmTmkydlpYSERxNFQ1T1VRb3V6cFA3VUh6QkRv?=
 =?utf-8?B?R1J0Z1dPRzhuVFRYejBEV3oyVjVCU3k5N1FOQXlNZHY1cTZtK1B3OC9JZk84?=
 =?utf-8?B?cTRzWEt4RjM5NE54M1hFWmtCR2pDODhEWGZyYXBPS2ViY21aZmE4ZHRkOEsz?=
 =?utf-8?B?VWluK2hiaXBaN2NMSTJ0bVcwa2pydGZnQTZLT1BWb2J6WER3SU1qSlk5cW9j?=
 =?utf-8?B?Mk1PWGJQdGtnR3UxMk5VTWVRMVZoMUpxT1NPMVZYaEtJTkRxamV2TmF2ZTJy?=
 =?utf-8?B?RlI2a1pBZU9IMW56a3dNNU50c2VRbDZsaGdqOURxQllHZXpvQ1V1WDh2a0ZW?=
 =?utf-8?B?TTZyaU12R1A2N2F5QVpBSHhFbjVacmp5eHdwcXhBVzRnV3I2RlNRNWQ3VlhT?=
 =?utf-8?B?L1hCZ1Q5UEczR1FCSHpnYTR5clJ2eFFTSmtKU0xVSDQvRDRNL2psY1oyMHRi?=
 =?utf-8?B?UzNjck0yS3BIbVNLTzRuK3p3TS9jSlg4OHp1UzV3MTA0ZUFvSXVQb1FMdGFI?=
 =?utf-8?B?RUpJRmlRZXUxd0xRWnphYXh6c2xWQnpHOU1ZVi9xRXpZb1g1TWtvUFlLVnpo?=
 =?utf-8?B?T0lnNjZXcDZyN2pjclJJdno1NFVrcHVNYnNsK2U1dE10QTFDNUtiYVNCeGFo?=
 =?utf-8?B?UjlBK0x5RTVhL1dGVnFzcDROMTVZeDlyVDhMOUNLVlZLTmJmMFdrVHpjYUZY?=
 =?utf-8?B?cngzU21YTWpFZUdFSFhaN1JKUDV3bUp0cXBnc1dFZERrRVF2bklOZldHR2d6?=
 =?utf-8?B?dk9ZVVh4emxJMjN5bkd3eWdGMkFtRGxacFJDdklYY0FmUXRGVVc0TkV5b3ZW?=
 =?utf-8?B?dGJjSloyU0xRT3QwRzkwaXBkci9JekpKWWwwZEVSbTJXUHVPKzI0aTJ6ZXpV?=
 =?utf-8?B?RDRybEpHNGs4eHRKdlJTVnhrNXlKbThFN1NXNnJRSGdWcm1rTnZUeHJyUDJY?=
 =?utf-8?B?V2IrZkFtZnRNdnpzaVBsbkhlYjRBcktZUnVXTnVjMTlyWHcyRmpqQ2RkbEdO?=
 =?utf-8?B?WVlWUnpZU1NUZHc1OFdoSXZiUmJobUdmMDdLc1J1QWJCbUJrM01OWWhZeTFI?=
 =?utf-8?B?aEhtcG02bkRnL2srbHVEVzNybG1TQjhUbnRwdDZXc3l5ZXM2VjVGaUJITHlR?=
 =?utf-8?B?OHZub005Nlc4eUhpSHkzSE82TVE3RG00M3BnSDlWd05WdlBJUEZlZHNDNTU3?=
 =?utf-8?B?U29oQ0RLVFh1eis4M1BoQnUvUVpxWXRxbEN4TmZmU1ZKOHQwNnBTa1kxeVF0?=
 =?utf-8?B?QVp1bzVKQ09wemp1cTZBeUY4NE9qRjJ5NzdJLzYrZTF2NmxzUjYwM3AvSlN3?=
 =?utf-8?B?d200RkJWM0tHRElyYnkvSkI1dzkxSkgrbGIzUzdTRGRoVzZaM1VQanA2VWVI?=
 =?utf-8?B?TGZ2QWVWVVp4b0tvM0hUZ1M0Mmt2M2RPZVU0bmlSRSs3aXZYZEhtd3pSeUFQ?=
 =?utf-8?B?cEt3TjJlUG95ZVZ6NGplSlhvSFBhM1BJeTZKcG9YUDB6UHNwcW9aYUdkbzI3?=
 =?utf-8?B?TjlmSmUwaDFQbkorc0RiekRWTzYzeEUvYTV4M25QQmE4R1h6bXgxQnJUV1cx?=
 =?utf-8?Q?DsvLhBYdpH1L2YIZaUIeOWR4g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4ae8e0-e056-4830-cbe0-08dc9465d8f3
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:53:53.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+wX+sTlWuMo6tkd8hlK7YfPI+/nHutB8NDatTJOmxE2t+PYq9/BznODif4FChuBz3A/g+hHNSr2G4AOw0ATng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736

Hi Jonathan,

I added responses inline below.

On 6/20/24 07:53, Jonathan Cameron wrote:
> On Mon, 17 Jun 2024 15:04:08 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The cxl_pci driver uses kernel trace functions to log RAS errors for
>> endpoints and RCH downstream ports. The same is needed for CXL root ports,
>> CXL downstream switch ports, and CXL upstream switch ports.
>>
>> Add RAS correctable and RAS uncorrectable trace logging functions for
>> CXL PCIE ports.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/trace.h | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index e5f13260fc52..5cfd9952d88a 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -48,6 +48,23 @@
>>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>>  )
>>  
>> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> +	TP_PROTO(struct device *dev, u32 status),
> 
> By comparison with existing code, why no fe or header
> log?  Don't exist for ports for some reason?
> Serial number of the port might also be useful.
> 

The AER FE and header are the same for ports and the logging 
needs to be added here.

There is no serial number for the ports.

Regards,
Terry

>> +	TP_ARGS(dev, status),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__field(u32, status)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname, dev_name(dev));
>> +		__entry->status = status;
>> +	),
>> +	TP_printk("device=%s status='%s'",
>> +		  __get_str(devname),
>> +		  show_uc_errs(__entry->status)
>> +	)
>> +);
>> +
>>  TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>>  	TP_ARGS(cxlmd, status, fe, hl),
>> @@ -96,6 +113,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>>  )
>>  
>> +TRACE_EVENT(cxl_port_aer_correctable_error,
>> +	TP_PROTO(struct device *dev, u32 status),
>> +	TP_ARGS(dev, status),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__field(u32, status)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname, dev_name(dev));
>> +		__entry->status = status;
>> +	),
>> +	TP_printk("device=%s status='%s'",
>> +		  __get_str(devname),
>> +		  show_ce_errs(__entry->status)
>> +	)
>> +);
>> +
>>  TRACE_EVENT(cxl_aer_correctable_error,
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>>  	TP_ARGS(cxlmd, status),
> 
