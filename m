Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AE1F63DF;
	Tue,  7 Jan 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267564; cv=fail; b=mwuz0VUnlh9Rzw/RV4ig/4y61+NfSkDH6V79LLc41KfbQwO8p7Zz3O0Tp8lCwWuvN9x0aKrNwBeAwF6m96/m8bMt7ycoyt12lJL9Pv1L8eNezVtpt7uSdwNZdKFwb0tpE9246H+nJJ/fFvnvSOm6bvOEs34sLkc0Z5Ti6EyVQvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267564; c=relaxed/simple;
	bh=/ESPMO81TdY4+wjDczjwJ9l0NHS5qWtyBennjm4BDFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m6QyihwvkUJZcjpvm1DQFzAto6GbEof6dZmgZ5vsZo8AH0aljZ6Qe8iz0v4N85EGW/mSZsN+avMsjMQo28/mXq3t05ZPgsQ4FxtPE6EvLF6Z+xbZ8JVe+HhiAgYHVzNsdAj+mRqUSsYMgnyWMEC2gZwY5RZMT0Jhr5yDjar/45Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OG9I6oDp; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OG9I6oDp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GP8cZV0w+XBvixj77I97+t6GdKzVsbAkZOs9/wGAv/iyJsLjUjQmAEu1t+SBYPvDhMrig7iLhAmaciV5h0WoayYbFxitDGWhz31mF3p+XgeazYSQFEnd3aN++wdeVOFIhVhS5QlC8BQKPj9Tvbi4rzvh12x5IhWhBaElQrtsh3vfHWv8zJ8yV4VxwV8TFwPbaW3lYCJhgTGqvjLkmy8ILlQqCSv4kFdCq1A1wSkfw86Fsk5rPSw2Gwkii9Bmqv/BLBpK4XLTh5o9RIiomPoYoJ0kTZAUBRNoJNp6OlsDYLoaL/c9FLAAF2CA18MuvzroZ8Ju4EzS9PpYGOnQifgSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZVZ+JpY26AY/CfJmwPtCC1PdiPey2YpL2e7x5JFo4Y=;
 b=CPF0hqRSUNm+yPLTuI18WbyFWvmZYiT/bEFRAluRchMeIW1a/xDDAIY1WTJnfkwaIbL3sCzg8JGmeskJSXtadpx3i07aNbCQg6TwRIcjYGBgJv/Am/JJTPDfXvhysPM3wzVzwBY2dTDDSKk+nGPZHGNnRL24sUZsrdzXSdrPLdJ6GiOABIjUHa0g7HwohTAm8yQuZQaLJ6ooYY+023fGCi3MiJv/SLTriQ96QgC9mD5thehrG/Ot/T1buspaI9I/Wc08HCzlGX5sjPr7Q05HpOie3Ob4p0EqAt9/e1glPup8i6N5OxmbvqS8pdrHGly8+A90bck4yURRp7TIKmlsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZVZ+JpY26AY/CfJmwPtCC1PdiPey2YpL2e7x5JFo4Y=;
 b=OG9I6oDprmbJcDgPDceB4MNCb58EOq9UX/XCok5FejT7NHRxFVwuSWP3AA6P3glXOidcaLCyWR/r+1xTk0CcXpFkbD4w392sKd7AVxlJjgk89cG8IMh9k8JszA2EmB9wbf8lEZJddo4s3gq95ZYDNgXfhRaFOgUMZ1s+eBas56Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 16:32:37 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 16:32:37 +0000
Date: Tue, 7 Jan 2025 17:32:31 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z31XH8jyVa9nHKep@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107141015.3367194-26-rrichter@amd.com>
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4191bc-03c3-496d-c306-08dd2f38e561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ziswd1dqQWxKM0NBaGd4TkFkQnZubHVrSU5vY0JSczhxbVBsbU5jeXpReVVz?=
 =?utf-8?B?UDhFQUwwdHVsL1F1cm9NYTVzQ1VnR0o0a0h3UjdjWThleWZsdEhqTDdRMUJD?=
 =?utf-8?B?U3hPQ2haZHJlbEZhaDZ5cXRmMWhkM1o4S3pLSTIxTTUreTlvcEdTNFljSUZv?=
 =?utf-8?B?NlZQdWJDdCswWEg5bm84UXhhL3UydE9paGYxL0pWdythYi9TZ3BhdU9DNFpH?=
 =?utf-8?B?ZHUvOHpBUGpaeG5Kc3NudlNieWVvL0cvSlZQOUNHdHM1d0hqOWNlakZEWjU2?=
 =?utf-8?B?dUdaRzViYTczYlZwV0pzRzFYNUYrTFNDaWxCRHdYamFKTWdhejlxVmFKRmRS?=
 =?utf-8?B?RitFNUZ5SjV5aHBDVVVjQVpwc2lrcmwxdWtjY0xsR01PeGgzYS94T0s0QlVz?=
 =?utf-8?B?bjk2KzJ3Kys1dlJ5R3NTZ1o5dGdNS0JmVDVNUDdQc0NRdjcxMWQ2dXpncmI4?=
 =?utf-8?B?Qy9NTnZmQUJ6V0o3NkR3TTRmYWxPaWNOUjFsZmtGdTh3T1RWNERDZWdpOEJW?=
 =?utf-8?B?QVRxL0N5bjg5VUlMNExKKzgyTEFlN21JeTNpc1BQMTI2UUpUNzdVNjFYaUN0?=
 =?utf-8?B?Z3hwNFM2ZXhQd3ZUVXhwcjVHS1BOUFIvSGtoRWtDODdEODVVaE92Y0lkdnRS?=
 =?utf-8?B?L0VEbEhmbkpKSWtaTVBQSmYzZHNmK2ZLZGZaMkhUR25wU2lZaENuRVRTQS91?=
 =?utf-8?B?eWFRV0tTYnkvMWNlNXgvYklIQ1ladlVXYXNUbVV0UG8rdld3STA2MU1SYnV4?=
 =?utf-8?B?c1BWS0dsc3E2N3lmWlIrL2pGOG43dmRMWVk5SmJWZysxdWMxOUhiUVU3QnRo?=
 =?utf-8?B?ek9VUU9maGlOOEkrMEJqSlNGd0l0K1dHZjQ0bWE3MnFRT1dpSCtsRVUxSS9I?=
 =?utf-8?B?WHYvZWJUaUFWTkJycHMvMVA2MEhpb1EydHNaUTNWWG9WRUJnZEMvLy9PUEhH?=
 =?utf-8?B?MnpYZXplNDRpc0dGM3JxNkpNR25ySGsvQmpGRzYvb0ZrVExuVlgwVHZVNXBY?=
 =?utf-8?B?WmMvTkRjQk0rK1lpaTIxeWtqb1M2b20wMkNZdGNZQkJ3RjBRRlo0amVQR05j?=
 =?utf-8?B?Z0poTjJoOGd1VXBISWtpbkIzUWN4enNwcjFPdFpLRWVrMEtBMktxcmhvaUxQ?=
 =?utf-8?B?dG5yaWdvclZ6NE03ZEl4TVZCd1o4MFlqdkJBNmd1YUNJT2VKZmFibGllTHpk?=
 =?utf-8?B?VjJEZTF6SkY3cDRDdjVZN0cyVHhkZm0zblNldU5iWnA5eTQ1MzZTMEovVXNQ?=
 =?utf-8?B?VmJOOFdZZjBQRTVZNWZqN1ZTejRNYyszOWlnbXN1MEljTGN4bkMyZUNOUjBH?=
 =?utf-8?B?b1FaZDY0ODB3Mng0cGRCRlNNemd2Mlcwb1NWVGtnbmVJSElNc1V0MFYySmVX?=
 =?utf-8?B?SkhJanpvYmdJbERJcDhZeGFSaDhBaERMeTg1Z2JvWFFWZWNQUGhuaExiVWZS?=
 =?utf-8?B?MUtNLy9ta3FBOEZpM1JuMkVCNG5nMmQwQmpLNWdFbW56eXY1UTVlRFllOFlT?=
 =?utf-8?B?SkZNQTVZWk5tbUs0ZWFldGdWWFlETFE3WWg4UWc2L2Z1d1ViTnBsNEFqb2tl?=
 =?utf-8?B?aGtMcEJvU29JT1Q5MHVXeVQwNmpoMDZNTXRqRzh4QVBiUXlucHRUL0Z6Yndm?=
 =?utf-8?B?MnNlYlIrR3hxM3VUZ09LRUgrZXkzbWpGNEExYjhMRmJubTdQWmQxZm5xNXNU?=
 =?utf-8?B?d2tNbmxSUTNBblpRMEdZN3ozOTlqc2MxaWp0UEZkWXBOTGxTditycDhLNndP?=
 =?utf-8?B?ZlpUcUZxRG9KKzV1aElpek01WDJpdnlzUngvbXFwVytCdGFjZDA4dGdPSTVl?=
 =?utf-8?B?SEdxek5tUFZURlpMVzR3YVBTYmNlUFlHUmswQzJNNkhKZjU2OGp3bnJ1RkFN?=
 =?utf-8?Q?JWwONHePKcGB3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzdPTERoMDJSalFaYmw2dEdNQyt2TEgwZTVlN0cyN0t5T21uNWV0akZlWEdz?=
 =?utf-8?B?QVVlaFpLdjZsWCt4R2ZoU3lETzI5YUVpcTRQaElVeTVmM2hyTks3eVFlNWk5?=
 =?utf-8?B?UnhmNHh3Y1Rta09mYllUdUhTbXlXNm9odnVFR0RVTHVMcTcyWkFNdm5pSk53?=
 =?utf-8?B?cjBMc1N5WWUzek04TzN0T0VvRVRiZk4vQ0pJTE51czZzcS8zNUJUSVFtOTha?=
 =?utf-8?B?bTNHZVd2KzdONEI0UE1wU1Z2RWtTaFZpNmtLS3RoNFBOZmJuWmZIeGNkcnpF?=
 =?utf-8?B?bzU1ajI3S3d3bStrK1RnTDFac2hLY25Xb1JCNXVxTFRQNXRKRTQxcTl6cEJ5?=
 =?utf-8?B?Zk1aU3ZDcjJiSFRBYnpWdHZkMnJzZ1NBeWQzaENzK1B0cUFBb08xYzNYWjFj?=
 =?utf-8?B?YTVhR2pvM3ExcXFJYTNkSlhnYzlLbkZyL09RRmVxQzNnYUtlcTd1ak9LUnp6?=
 =?utf-8?B?M2U1YUg5eHdZTG5aY1B3dGIvQ1MydEtPQzJhbVhsbjhkNC9uZTVieFR6OEI3?=
 =?utf-8?B?MGVxWURMZ2M1Z014dFdYajlpcStRbTVaM3Z5YThraXlKOHVGbzFKZkVOMGFo?=
 =?utf-8?B?cVRPRlU2b0RlbGZ1MXpnYkpvV2JTZHZLQzJmZEh0bGtrcjJXYTF5UWQzbXY2?=
 =?utf-8?B?eFpsOVpYYkc5dyszZThuaG9EUFhkWGFvS1N6QWg1MVVOY0t4akgrL0ZNaG5E?=
 =?utf-8?B?REFhNUZqQlhzWDJaTjl4TFpHS1pwcU5NR081Ti9MRmN1T2tPektkRUFQWWlR?=
 =?utf-8?B?ZHQ4bFp3K2Y1L0o2TytwU2NZM2REalFzSTI1QmpGa3B2UmxiQXhZOHptTHFN?=
 =?utf-8?B?Y0ZLRUc0d0R0dVk5OUxRbm9TU3A2U1NCaGNVSGlLanJqZlRoOEFaNGY1c3VF?=
 =?utf-8?B?MDNTa3FpZDNxWkZib25IZXAyZk4xazBYWUcyb003MXk1NmtaZ3dnT3ZMeEx0?=
 =?utf-8?B?Tk1kWW80NUxPeWlSbWVWdko5RUdXTFcyeVJuMGwxbkdtUkM0clFnNjM1SktE?=
 =?utf-8?B?Z3o4L0xWZWk2SENYUkxucTc2MTQ1SWRmMjg2cnR4RDlLZVA0TDBEdXgzZWw4?=
 =?utf-8?B?NnNPa3FobFhaTWN6eUNkUGRJRWQ4ZmtsRVZWMlpxdEhST2ZqOTUza2o1VDRv?=
 =?utf-8?B?U3R6UEtCVnZvZ2lQYis2dWdaa2ZmM1JKQ3A5bC9WSEJRMzdiaklJNFUrL2tE?=
 =?utf-8?B?U3dQNkNJSWxoTTdzcFdGYlFWVjN6ajl6bitJRUtrN2ZVaHpHenliaXRUODF4?=
 =?utf-8?B?WmFTVDNaZDZ5R3djeThDNHRYUlVCWW9neHBMcWVjemRUZUZ3ZU5WNHl4ME93?=
 =?utf-8?B?WEJqZjZTaWM3VTl3R0hVVnFQZ2s4a1k4WFF0c2VoLytxS2FxNmNPRFNSTVVL?=
 =?utf-8?B?elh4L0JWTFoxL0NTM2VYK0lwYmppa240blZ1U0p4cWV2emJhR0tOWG5sME1q?=
 =?utf-8?B?Q3RUbktMbXBIWjFVOGhZcXVVTGQxTHdpVGFoNjFLcXpYMEEvenliTVhMYW0r?=
 =?utf-8?B?UXJOYi9Oa25teVV1VFJPbDQwYVlkUWlEdXB0R0pIZ0JTMWtnTSt6MVVhOTQ5?=
 =?utf-8?B?N1BFRXdnOUErWjRsNlN4YjJrMDJPT1A3cVNqTUJIMlMraGluMi9ab1JHSlpM?=
 =?utf-8?B?S3Y5V1lnU0xUTFcyYjBrVFEvZ2dDWGZWK0w1YTNPaFhmelNvSlpJSjRkM01X?=
 =?utf-8?B?bC9QK1dxdCt3eGZNakZ0N29XRXhpMFdFRzZ6Yy94VW9TZlM4MFVQVWw2Q2dS?=
 =?utf-8?B?K01HWG5DMTUvcHJvalIvelFvRFJ5RDJsNXF3NEpuYUpDRlloaXJMQzZZU3hE?=
 =?utf-8?B?YlFjVUIxdDZrQ1ZMOXdrSnZZbXR4eWZQK2drNldhekhVOGJ4S2liTUlMZU5q?=
 =?utf-8?B?NlBWcDRtam16WS9oVkF2dGZOb2o3SzdidWZrbkhRMWx5MWNETjZEZHpXUG96?=
 =?utf-8?B?RHdCWWVneG5xQnliKy9TbDJ2VG5mNXI5Q3EwbFNhRUFtd3RMUUZ6d3BhUERy?=
 =?utf-8?B?cnBURDZVV1k0OHdjMS9mb2IyWjEweXhzQU1US3BxVUtHdW5NdCt1bXZTckNi?=
 =?utf-8?B?Mnp4MDdVdEhvU3YyNHpORGF4blp4M1dXR01NaldSMnNoTE5xVmFNd0VmdjJs?=
 =?utf-8?Q?0XtJdMkoDK13U7L/NbR+if9b8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4191bc-03c3-496d-c306-08dd2f38e561
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:32:37.2775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUjpOYFmVn3W+HhzcDYEJQJbjiW3hSgvYNZnYlnGI99fxpJXPrLXIaUf3ORrvqQJyPj47EW2pVEXR0ZWwC8zNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415

On 07.01.25 15:10:11, Robert Richter wrote:

> +#include <linux/prmt.h>

Note: linux/prmt.h is broken and causes a build error:

 ./include/linux/prmt.h:5:27: error: unknown type name ‘guid_t’
     5 | int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
       |                           ^~~~~~

A fix for this is handled through linux-acpi:

 https://patchwork.kernel.org/project/linux-acpi/patch/20250107161923.3387552-1-rrichter@amd.com/

I guess it will have been applied already once those cxl patches go
in.

Anyway, I will add it to a v2 to make testing easier.

Thanks,

-Robert
