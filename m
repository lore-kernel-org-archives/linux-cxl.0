Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2442C0B
	for <linux-cxl@vger.kernel.org>; Thu,  5 Sep 2024 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519133; cv=fail; b=Zl8dG68aPqDXrmE4/bigKm4JjPnSXB92xfpoK3bPPzTiu3LiZeSt0npEEJkzjC/05NnXJJmQtzTiIamfLnQnL1+b+uGO+ANe3DjO8QIY6KHVsfMwpl8g7wW+Ak4hzbL65J3AM2sFooebN3PXkrzBA6A3vT7eE5nOxAHnAfZEQZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519133; c=relaxed/simple;
	bh=qJNJQAt30TW5tXe2tNBbfAjiS/Uyi1jTPbI0bv8ME9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h7Kcmxs/9epMn1pbZbD9JR1tTn6irk1H5bnajP6EQ3/LXme0yxr61FG0e2UPKyqv77+MJ1XLv6eou9ARW17lTyi+mWGzF/35yyzclqjy7Pl/aVpqEZrDeyTf5A+3W6UBcGhx6Tiak/pMDKWVEu9i4HyNwELgWyqCDVR1hp+/gAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k96MV0mI; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k96MV0mI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSLp5Pvm6wWqbFeu5BljfJueGXvD1rC//Jr+YAtdXoFWGKl7e61Y+8HkjaFClJKKLM7Up4ZAl4VDunzA22EmVGIDqkqYbZIwoEY/9l8QuzwQ0htN48FvtFd336j5Or59eh1T1eB5OtZ2c5Vg0uQqiG8G0wmWujkxol1OWQdM/Hqnlnb/I+Ma72+jEe9ZOzK2SHm9FIuyZtnbcCgvdegPb9AtrxKTUrXRTp77DizE1n7Sl62VNVMvNJgbiuWv7udMuTMOm6yCSa7KLbWI4MaqsIeAsJdcerLHrGYSGodE9yrh7naT/qkTY/QwlHoRFLolOf04bz9ZfKKz3ckWcun23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuYet8AhqeJm1K/G2k3+qz90Hk1qNbx+BXVvnDG+Gws=;
 b=xLXTsrdsW8n0fG2lDsycn34ceYGlH5vcDMofIDZkbr3R0xna/ffgUdLzZztX9z//fkcAb5gS9Wk8ktwabyfRyHYRtYeWjHWubWfS1Z9uWv6xveQhTzGY59KQoFiq0Y/v9iu7joHgT/485jOOIvDJrMYB3gFKFIldhwKGVndFOJQLNEl5RUVd4yXikbj8GF4XoP8Ud06ltJig+8W7DBPkNWzbbd7zfmIClC8+cdp6Zsk+UQ+9kocadhh5djZfkJRbQ+JId6z3LwPjnQcPrZEtIYSW/2HzRXmyqvYEarq4iFt9irTRW5oS3tsMo37i5/D5JGKel5jZ62/VOe/iwyA3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuYet8AhqeJm1K/G2k3+qz90Hk1qNbx+BXVvnDG+Gws=;
 b=k96MV0mIMEFDld9sKX9i7BEe/Mwh0QNyAuwj+Mpl/mAqx6yEx0+Xoh/dbVLQtXpKtuKX7yE6t2h83JHcbO+JUjFtPYbkDJ+scDt9YAtX5fuPIGXD+HVXxVv3MsBIiWFbOWrfLz/8vk8oTe8d7FIStwOWsf4Wdtebwmx+OG0jQ7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 06:52:09 +0000
Received: from CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::3cf3:1328:d6cc:4476]) by CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::3cf3:1328:d6cc:4476%4]) with mapi id 15.20.7918.019; Thu, 5 Sep 2024
 06:52:08 +0000
Message-ID: <d86d41ca-923d-0c90-1480-8f48efac07e4@amd.com>
Date: Thu, 5 Sep 2024 07:51:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] cxl: move cxl headers to new linux/cxl/ directory
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, fan.ni@samsung.com
References: <20240904000020.1686611-1-dave.jiang@intel.com>
 <20240904000020.1686611-4-dave.jiang@intel.com>
 <e6cdb731-c2f1-5791-79ff-ff5835009475@amd.com>
 <66d91d844003d_286b294cf@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <66d91d844003d_286b294cf@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::26) To CH2PR12MB4199.namprd12.prod.outlook.com
 (2603:10b6:610:a7::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbd1897-0684-4458-789a-08dccd7742a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3JIV0NJeWh3Z1JyL0pOcGx2Wk1mUXhabXJlSnhweUtDR3pFR0E1S2xrQnhP?=
 =?utf-8?B?eDRqeDBPTWsvVkZLL25DcUpiTXBtQ3JqMitWczdYZ2k5V3pKOVoxalYrdWtP?=
 =?utf-8?B?aVBQa1RNMUVwbzNRbjRvbWNReFNlNFMzTm5iMUR3NVBySmhmUGxBUnYzVW9w?=
 =?utf-8?B?WHNUZjB4TlY2ajkxT2hrSnZyVVkvVmxnUkhrNDhWRVN5NU5rckFQSXAyWnd3?=
 =?utf-8?B?NW15YldSY2JTSFVlSE4rMWc2Umo0Kzc4MytubHpnOHN6VXVLdHozbm9Fb0R2?=
 =?utf-8?B?S25SMXpmNmtVUE9wbHBqV01IK0tZeGZCN1pTUUVwOTlJT09NSXo0dUhEWFRl?=
 =?utf-8?B?RkVmbU8zRmYzZjJQUU5lZXRyQTUweFVDcEc1YzUrbUNFcUtuZ2J4cUhySm12?=
 =?utf-8?B?RTBWR2NLY2hlOHBFbW5RRzdzL3JsN2JzUG9TQXlTWFhtSkJieUxtNFRsUDM1?=
 =?utf-8?B?dXBoRGY2SlcrZ2NRNUtEbXFYM0tYTlNYUGlmQytvZlluK0R3clNQWVpHV004?=
 =?utf-8?B?enk0V1M3WS9Kcmd0ZHhxSmVNNlFIREx1R05HK3JYc21qdU1TTm1iVEUyK2tP?=
 =?utf-8?B?WWp4bXZhZ0lVbUNUMGphTU10R1B3bjhValdrdTVRVi9yMnhyN1hZNzFHVmp3?=
 =?utf-8?B?V3JzZmRyVlVUYnFNQnFUcEcyMlJVMHdldThGRVRRTnpESE93ZWlZTzhwY1Mr?=
 =?utf-8?B?YzRUQWdXVXBLZm9YVkE5K3AvWHFXY3QzSXNVa1lVYVhEZFo3ZkNqWTc3SUlR?=
 =?utf-8?B?Smp5QlIvWTcrMjI1Q1Q1L2RlMHcxVXhWMndLcGxqdmFGV3RZbldoUGp2cklm?=
 =?utf-8?B?eFpLOTVxaXdHQ01iVlkxM3ZSUEM0U3JvSllvWEo4d2xKcnFEZWxsTzVjR1Rx?=
 =?utf-8?B?RkxiTkNzbHVUWW1wWUJNeFRWSXBVMUwvMzVXR25iQlFCaFBlMTM0dklNbDNJ?=
 =?utf-8?B?MUQyTmhFTVNJM05qeTBxOXJTQWI1c3l1d1VZZmJjWUhYeHVmOCt2REVnNW9E?=
 =?utf-8?B?YXMxaWtXK0N1S1hpRTVLelpDYzdaV3RscnlWSXNGZDJmOE9HaHJTck44K1BX?=
 =?utf-8?B?ZkNQd2d4c0xOYXZHN0xUT2FRRGNsbHdzZ0RiOXZWMXBYQjRmMHZoSFptOU5s?=
 =?utf-8?B?Rkd5eWVnU0RieHhNM1dXaGFDQ0YvOHBPbnU2R0QvOXIyMFk1ODU3bUxZQTdI?=
 =?utf-8?B?NWx4aXVWRXlIUFkyblJPMGZHS3JvZG5PSzVlYnNqUm4xQ3o0QWlTajJaUFhk?=
 =?utf-8?B?VVMxdTMxTXptQytlTWRIZ05hK1ZtY2MwTlJ0VDhJY0JvN04zeitWN0ZhSTRu?=
 =?utf-8?B?dE1QTkRzQ2JPWDQ2R0hINlR4cXBhYitHR1hmWFo2REhvRDNQN2lUMGZRZGV0?=
 =?utf-8?B?WHl3cFFrK3c3ZnROaWd2aXo0VGk5bmlWWTFKR0F5SURqeVJ6aGNKMGVhKzNR?=
 =?utf-8?B?MjJQcWJKcFhnTDVXYnJVU3IrT0RpS01WaVZrZmlYeUs5alBqZFpvNHowTVM1?=
 =?utf-8?B?cHd0RGpCUHNHU2dSU0JmSGxtY2tnNEM0dXNVTzlhY2FFYnFTWGt4aWg2N2lU?=
 =?utf-8?B?K1JRemZVclVEckUyaDFkTjlldGxLY09wR3RnSmhvYkRmcTk3V3Bpbk9ZYkJx?=
 =?utf-8?B?c0svSGpHV2hjSHFRY05xV2RjaGUwM2IwYkdiVndVYzA0RldLSDVaTS9QRWVx?=
 =?utf-8?B?ajVCZS92U3dtdmpDdVUrbmpUaUJ2Lzdaa1hDTk9pMEdrZDBTL3ZnU2xOUTkr?=
 =?utf-8?B?QTh2R3hTOEFWTmZQYUN2RXNTQ3kzQkJFcU5qSU56WStFMlMyUWIzcThUV00x?=
 =?utf-8?B?L0Y0L3ZXWTBScjhzcWgxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0hMRWpuNlpQR08yaC9jZ05BRnpuenB2VzNJZGRGRUR4NmU0SG8vOHJhTE5u?=
 =?utf-8?B?ZWJ1eWtkY01vei9ETFFoRnBnUHZnNjJwTXB2WHhEd0NpOElzUmlzQ2hOcTVX?=
 =?utf-8?B?TUo2bllpWXdXeGE4WVI2U25lMTNYZ1hsNXY3SmlYZVhFZXNwRmhIU2R2VDVU?=
 =?utf-8?B?TDl3aDNYVkxCMlNodmNQRDYyQ3NESDZxR1MwZ0ZHRXdvNGc5RkgzTjhFY2E0?=
 =?utf-8?B?VW9sUW9BRjdQY2VzdytLMndmYnVUUGZNUlNTNUxJNnIwTTQ0bC9WT1Fvck1Q?=
 =?utf-8?B?QkdMV0FPUXFCbXV1U1o2UHA3TXJDZmlDWE5LU1pDYjZ3cjhzZmdRa3Fsckpp?=
 =?utf-8?B?VlVKVTlzWWZmUzdVaXorTVkzaDJTN3lpQXQ1NE80K1ljWFVqbHpHR0s0Y2dT?=
 =?utf-8?B?VGdYSThVeFUzNFVCVFZ5cmd6Zjh0Uis2OFFabytuejczelU3QnRYTmR3L3l2?=
 =?utf-8?B?MnhYWkRhbVpPc0NDaGh2eVpyWDJMdXpnSGVlOW9oYUNzQnRQOWlHWWVZU1ZG?=
 =?utf-8?B?OW04Wm9JQ1oyUS9hOTQveWJGYnp5c2hvRSszTTBSNHFDd0t0Q0NoVWJtSmJr?=
 =?utf-8?B?MUFZTzI3ZzlLbWlTOGVyejhrTjJwN0paTUhJMVJoM2lPMUhRZkxIcUtXeHEz?=
 =?utf-8?B?QStJc0ozdlNFN1dHV2xDQ3NzU1NUOXJtYXdWNlZsbXRpMnhTN0FCTnBJSlVL?=
 =?utf-8?B?em1qemZhdUFlbHpWYmtCcEFoVFhQckJlNE1YRUx0d2YxS2VjRUhlcVpNczM4?=
 =?utf-8?B?MDJreWp5QytnbUw3bTFFL3A0OW1EbHBaL1QvUHNSVDFWSTFOUm9yWSttTVlh?=
 =?utf-8?B?eGpYcmxKQWd4ZmRJWXU4L0xKbzM4ME5ueG5Gek9JZjh5TmtqeG94ZVpwOVBF?=
 =?utf-8?B?L1lYbzdMTTJzLzh4SjJ4TStKVWVIV1lZeUZnL0R5YnYvRlJkclR3V2ZkQUlC?=
 =?utf-8?B?VGpNZ0dDbHc4VEdQZ2JVSkVobEhhdWVvdHZWZEdpZ2ZSeUZRMFFPUnpVb1F3?=
 =?utf-8?B?d0JFR1JCb2R3UWtCb042K3BmZmRKSHBFLzZxQVB2NWEva1hqTjlMRGZkS2RX?=
 =?utf-8?B?eXpxcG5xOE5TNHg0amZxQ2dqTjQ4NFRCNHJBMWkxaXFzVXZqVTQwVC9ld25I?=
 =?utf-8?B?NlE2TzR1L0UvZ3E0ckVQdXRscEowZXNnSnJmR0lGY3k2WkJnNys0WVpaK05a?=
 =?utf-8?B?RDRqY3pnQmJvaWlONjFSZ3lnYXpGcFp3dENBRmFlMmgrL1J4ZkJJYzZHSm1t?=
 =?utf-8?B?SXFxKzJPVW91d2dvNzhHYURpTG43V0J2eERhbjZQcXdDakxra3JqMVdlNG1n?=
 =?utf-8?B?YVNjSkppQjVyVlZWc0tlK3RhR2N4VTh3ZDcxOUFESmtFNk1USVBxMVdxT2hS?=
 =?utf-8?B?ZXdxdS8wTmlvcm9KSXl5UUNyOGh6azVUMTNONVV2ejVIWEk3ME8rekI4NUFv?=
 =?utf-8?B?UDhFakxOaFlwQU1KclE3OE1RYU1adW5RbUx2ZGVpSHdOTmd1WDVaQVlVenhZ?=
 =?utf-8?B?RGUyZHhSb1N4OU9IT255YVcyZE5hbFVYRXEvK0FVUlN1M0pVUDgxWWNTeE50?=
 =?utf-8?B?MEJ0Z2YxTE9NYTU2dHhKbDczV2F3WGJXUjlKcjA1cnpSaDdUSGd2Z20rVTBS?=
 =?utf-8?B?cVNWSm9OaGxxMGM1UkVuUEo0bWpxQnRhMWt3ZEtXVjV2ZVNCWnQxRTFpMHV2?=
 =?utf-8?B?T2UxYk1qamtoUDZuT0tOejV0bi90UWtIV1hDRzhUZ0RHQXZjZC9lcmg5VW5k?=
 =?utf-8?B?ZjJVS085RDk0bytPSkxYOXhxZUg1eUdkb0hURUI0SHh1dHB1dkcxM203TFFU?=
 =?utf-8?B?TDVCWHdaVlZTTWYxWmRRVW9lR281bEVvVUh1dHdxUEJHS3l4KzNNcHVuQTlI?=
 =?utf-8?B?VmpsZk9YWVlSMWpYWTV1ZW9VSWhpOFVNNis4YTJGSXFPb3pzQTk0djAyVnZn?=
 =?utf-8?B?SlFVdjBqNVcwejJWNG8zRTU3TnFmVnJFcXNPTkRYN0VSRXNDOC80TjVta1cz?=
 =?utf-8?B?RjdqaXVST0prZTQ3ZU9mdkVFTFM5UjZleW1mVVBXR09TVWgwdTZYaEpNVGdz?=
 =?utf-8?B?b0M2cEpkYWJ4OS9MaGdPRW9VRXBjZHBxa0NyNDl4dndNbElaUVZOVnVLclVH?=
 =?utf-8?Q?tsSJD72Ghju4yRsPGBQ9naSh1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbd1897-0684-4458-789a-08dccd7742a1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 06:52:08.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG5qHbwZtUUDt/1iQ+ZuuNT5awd5LCzWhIcflZ2wLnQNFoxH7yJPM05OmR5YsH4n73S8Sl64+n+Y/2QrgXxphQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521


On 9/5/24 03:55, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 9/4/24 00:59, Dave Jiang wrote:
>>> Group all cxl related kernel headers into include/linux/cxl directory.
>>
>> I tried to do this in the RFC for Type2 support.
>>
>> I was told to just move the required bits for accel drivers able to do
>> CXL initialization,
>>
>> What has changed since then?
> I saw this subject line fly by and had the same thought, but now that I
> come to read it there is a significant difference.
>
> This is not "move cxl headers to new linux/cxl/ directory" this is
> "rename existing cxl headers in include/linux/ to include/linux/cxl/".
>
> Compare that to the proposal to move all drivers/cxl/*.h headers to
> include/linux/.


Right. My bad. I did just pay attention to the commit message.


>
> Now, I do not think it makes sense to place these cross-driver cxl headers under
> include/linux/cxl/, just place them under include/cxl/.


Not sure you are telling this to me or to Dave.

FWIW:

I have almost ready v3 and I'm adding headers to include/linux/cxl after 
this directory was created after v2.

As I understand it, include/linux implies headers to be used by kernel 
code, with headers to just include those to be used by user space.

The headers added in v3 are for accel drivers so it makes sense to me to 
be include/linux/cxl.


> However, I do not understand the motivation. It's not like a new header
> is being added and that is the final straw that merits moving the
> existing headers. Most include/$subsys/ directories have more than 2
> header files.
>
> So what is the pain motivating this move?
