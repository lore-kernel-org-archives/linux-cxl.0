Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5AF383;
	Wed,  4 Dec 2024 04:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287487; cv=fail; b=EiBjpXRv7ckO4eKnf8dyK920wrXpdJOkrJqxsOPeFnC5B0n1+X74c06zv+yy107RBCDRk60X3AC0LLaUEtu5LbrypVcJS9rob/f+GO7/VtNmTDbpYYvtATRvu4J+4XQMf5s3XdKz9us8LJMFYK27G/L1napyzDA/h0YUz7M/9sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287487; c=relaxed/simple;
	bh=gzmpRmatPQxAj/z/5ihQjogQHqlBDrSknHWSOdNzznw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rEwmwwdmC2Ib5YD+o8oqLupO6NaWY1tM0jIKUoU5/iD2MiwWbitU9/5OiKfcNaDOhLrxSG98VVJ6dMRahg7D182C9wOxYckxdIjUZP2E+4EL9tS8Xcc+udcGQ5uSD3+M7uHFY/2Nwowet2jr+DWjwcecKncr+9uSOaouB5BokPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JXCYaUTj; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JXCYaUTj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vp1Vc+klsYRZDVxbiuuXeJ3eB3oHF7AsPc4yH831v3keIcBOy78qPDtJdMUbjQncZCLejL+JZKO5CzzTQrFD7QiyCAQMl1IgUGk9TIlemz/q0s72aDHMo/f7OVl1PkQInDBixPbLzn323L6+f3Jf/h3+pvaVacDeLJQv2UYoLQChVa/5LgBLQ05eGHJ9LoZayTGaRgDX8lgheGUWJv9dlsmDvgDMYsmo+Mmxx91rwrQ/tAkrjQSMxS9++TiMW8AjkMXGeFnL6sp1Z6/TdbuCt18Um+SU+qnQ7tfAbyZc4Rs+ridhDA+AQB5FFdjeATb460+f55v7WcTSi1IKHB6KGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scjaPQd8ZHnSMXb/J/qdc7RXWvq/qx49E++9mBI0UqU=;
 b=RgryX5x9lOITuQ8DgJt4s0zLq717UyF5HozT3IoN7GRUXcIra3rzDE9TZcdw7wRs0ehBriNOV5oNPYcpdsZ8UsBdRJJKHRv9Q25q913vLDkjRaAcUbi4fAOeDYRmCmGNjerwa6NesDpcOmlCIgP6MFeEa2j/l3l9PNcPQBHUkhHiSTAy/as5tPFmAokcQEEaJ4KjEl1l2Ivug+rsxd7+EFK2bMd+V59Nrehu3XXNSf7x6ZyS9msqZMDOqHI7oksqekqNXY6GkuTJ2cb9M+SBM6Hu1PsBGw5wXcTXdrQvwlJhOvrmTrqZtcXEhprX4k1E11vtpnC8HD8q0vJHsn+OmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scjaPQd8ZHnSMXb/J/qdc7RXWvq/qx49E++9mBI0UqU=;
 b=JXCYaUTjI8+KUXrPOvuWV6dErjCPpA7D++T+LSiHILQrlFJDypEka7Pwa61nJmnVP+CuWmsfffmaWD2x/FJudur0iXw7g7nLhDzAsfyHb020ymbxe3dUrOL35863HnpZJ5GOdhzHbk+UDm36DcQ5EVy7zpmxazn/zuBeNL+5Ovk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 04:44:42 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 04:44:42 +0000
Message-ID: <8fdb21b6-5ea4-4be3-bfac-901ecd638897@amd.com>
Date: Wed, 4 Dec 2024 10:14:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, bharata@amd.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>, David Hildenbrand
 <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Baoquan He <bhe@redhat.com>, ilpo.jarvinen@linux.intel.com,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Fontenot Nathan <Nathan.Fontenot@amd.com>, Wei Huang <wei.huang2@amd.com>
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
 <87frn5wac3.fsf@DESKTOP-5N7EMDA> <Z08KiPwwiw72Vo9R@smile.fi.intel.com>
 <87iks06w17.fsf@DESKTOP-5N7EMDA> <Z0_F8EuGpxPPytFM@smile.fi.intel.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <Z0_F8EuGpxPPytFM@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::13) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: c6eb1f19-6436-45ff-d8d3-08dd141e5e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUhob2gwTDk4TWdlaUc5R1gvMnNzdWlxaWtlWk5SOTkrWXc2anBDR3hkdURS?=
 =?utf-8?B?SUlPSTM3ZEpRdWIxaG1JZWVYeG5Zb28yR0tZQm5EekVhd0xTWUgwZ0ZYbGd0?=
 =?utf-8?B?b2ZtWG5xRkN3K1pndkZXcFhBaTE0VENaZkRnQkVkaVV6dFRsUldCc0JIMmh0?=
 =?utf-8?B?SHhyRER2SU5nZ3RhZThsWDFYdlllMnpIRG5LZHFKNWI4Z3dteVd6ZDdTZUcy?=
 =?utf-8?B?ZXpCOUFYeGUyQWh5SVJ4S1NyajFwL2tWWWQrckdSMVhzRENhRE0yK1hZLzFS?=
 =?utf-8?B?Y0dOdjZFMURmNFFrUElEbktBNzdEdEk5YmtGbjNMTkdhd0NOK3U0UzRJcFFi?=
 =?utf-8?B?ZWRxcTBLSnlDRGpxM3FibUNldERXUzAzZnJnV0N6b1lROVg4T0FTQVVnWlFW?=
 =?utf-8?B?SXRJVHhmTFJrVUg4VlFXenlzcHNWaFh5WjYvcnB2aGRiWjJpM251aUl3OTJw?=
 =?utf-8?B?bHJrTEVUWHpCS1JqVThaYVBCeEdRZVk5aFNTT3RsTFZPK2pNU1JTWUUyTm5E?=
 =?utf-8?B?MGZaSDFyYUJaTnJucEQvMlo5dXVWYmJ1N29QdUxaYjlHRTMydHZNZW42czlu?=
 =?utf-8?B?YXQrMk5paTBtU2tBdjFkcGpIUDF1NUpzOGNVSVNLQ0tJN0l5QW5yclVyRUgv?=
 =?utf-8?B?NUczaUN4cWlUQjFmb1NYVjdocjdKNHV1Q25xSzZDK1VXK3F6SkIrS3dOYzVp?=
 =?utf-8?B?Vnp6eVRFd1BTRFVOVXp3TGxFR1R0NEtjaUZOUWF2cjkxNmJMaWh6MWlnVDNS?=
 =?utf-8?B?VVVsWlVVTzEvT0lQa3VDRkFLYkZ6L1hsWEVNbGRZMUF1Wi9NYkwxbkpOdnhn?=
 =?utf-8?B?OXo5Y1FsaUZ5MldNZkRQbnVhZE5seGdaR3hCNHN5ZFM1ejdBYk14QS9qa2I1?=
 =?utf-8?B?VEhZZlFWZC8xcDltaE1peExSazNFdi9pRjhhd0NFYWdrTGRZcEpJbTExaWYy?=
 =?utf-8?B?STlhbmhQVm1UdFF0aXk5bE9RQnhGc1hKbGRDYllBUXNYQ2ZZZXRNOVQ4Mzdh?=
 =?utf-8?B?VEVISkNWTkQwNWhaZ3ZHZktFaWIxRVN0djhkbmprenVITkxyWGNsZVM3OEdJ?=
 =?utf-8?B?aHRWVzJHRU9wVWVIb2lXS3ZnRlJ6c1NMR2pQZm1VN1BkYy9JamtncTMyZm9G?=
 =?utf-8?B?M0cwYkMrUzNtTndtdzBJb3BHd2xQN1ROTExQYVdSM3g2blk1YmJ2M1JGbGcx?=
 =?utf-8?B?TzNTcGVIYkN2ZDlMYlNpcEtBZnFrcHV6d3hvSm9NRG9HWDZHd3hnNlp0N1NB?=
 =?utf-8?B?OFpaK3R3RmJZUTNtVlk4cTdrREhZSFlRZTdNcVdRUGxxMGlSVURDVGdGMWFO?=
 =?utf-8?B?RjM0UG5sZ3NvazlFSGp5cStOTmhWSENPT0d4OUtnTllqQkNmY2hvSTVSQVU0?=
 =?utf-8?B?djFNZlZqdmk4RWsvSFczaGNzVkhqUmtvM3crYXBlOXF6aFoxbFV6Mm4zcVBR?=
 =?utf-8?B?amF6dzg3U3FBQWVhV0gvNEoxcjR4OS9yOEFNcGY2cG9UdUlRNktVV3BkdU9S?=
 =?utf-8?B?TTE3dUpWU0NqSmU4cy9YWlV4bXpWQ1pkdUlEVmw4TVJTODNnS09oeVZpdUNx?=
 =?utf-8?B?eXhscEYrbjdpcUxadnEvRDdDS2dUK0kxd0QxVkFENktMZlM5OGJxalZYUFR3?=
 =?utf-8?B?V1M1UEFHWXBrMExGY1YrT2wzRDhDVTRLcXpHRzNwcGl4d0tBRHVkc2FKZFZq?=
 =?utf-8?B?dW1mWWV4K3RBS3lBV0FkQmhyQkdML1NxQkR0eEwrNng0UzdoVzBjZlpRVDRs?=
 =?utf-8?Q?YVUN1x7CY/O0D7M/kA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a09rRUtiNHhRRW5FMTVrRk01dUg1a2NXVUNtL25KVmpvbzN5cFF1a0ZHR3Uw?=
 =?utf-8?B?emxndEUyS0FCcTNMNFBLdStqL0xpd1lJVml3VHFoUWljeFhJUG5yVkpObXRU?=
 =?utf-8?B?aXZTazRvNldwN0VtR0VTUmovbEFMaUtkZEtsaVIwa2c2L0pTZFZzeTRVdTht?=
 =?utf-8?B?SEZTYTl1clVZWVV2RTFNYTI4L054Y2R4N01oU2lpWjFrd1JiYjF4SUd2TFJC?=
 =?utf-8?B?ckR1aWNUamtKZDRneHpLcXZjelJCNFlSR3paR0NYZU4yQjcyb2l5TVhaWHBS?=
 =?utf-8?B?a2huMWlYVEcwaGtkREd5TGxpT1ZTNkRuVFlSd1FoNmFtQ3g1cmRKdTNEWWxr?=
 =?utf-8?B?Q3V6VG5Td2ZRMTQ0eVdZVXA1NnZERVlNb1ZiL2QwNzUzSWt0Y1lJdHhETDJQ?=
 =?utf-8?B?Nlc3ajZmQXEzVllFVC94TkovcWx0c1VBUTR5cmdWL2ZlZjh4RUZaSmJXL3dG?=
 =?utf-8?B?S3JqbmZMZ0JFL0ZFUloyNWFJYkdPbC9WTHFPV3dOb3h0VXhNSjRvV1lUQTlE?=
 =?utf-8?B?L1A4N1ZsZjBUZmNGanVYMkttMVdUdTdCMHU4eTlLWFBHdHJUZlZpVkxKSDlY?=
 =?utf-8?B?RHVLT3BMdmZGODFkdzZnT2pCWFR6d1EwUzVRbitMUDJSbWZ5cEY0MTlDdUxp?=
 =?utf-8?B?dk44TkRhdnk4dCtZaEpDSXBGREpyWnhhbzBZaWxHZnViQkg4dUU5NGYwYVNS?=
 =?utf-8?B?R01pcWRmcWNVbkxEN3djK2VDOGF2Mk9SNXRwZzF3eHErSG9IWTZIYXpSTzhU?=
 =?utf-8?B?NzBUM2o2c0pxVEJtUWNkcWV1L2RHOXJnbDRab2wrTEJwVHJ0MlZySWZ0MzI2?=
 =?utf-8?B?d3A3MXFvSG1zazBpM0RLZGlibWtxMEYvaTVjTUdMMllYQXgzeWFOY0NCUTlz?=
 =?utf-8?B?SVVDSGlkcEVEdVQybCtlQi81MkM0SmhqTERITktSQkt4Si9oVWx1N3FsZDV2?=
 =?utf-8?B?MVIyV2duR3Y2djliNkw3czlBeTRPN0hRWjVxdUlWU1dBbjBlY3FjdTlJazdn?=
 =?utf-8?B?YzJ5VTZXR2w4Y3k1VGl3MTNac21EZmtMSVlJWXhQRDlCM2NDV0w0NERZK1Mz?=
 =?utf-8?B?UGRmUmJGa0FyN0RuK2RWK2ZsNGo4Snl6a2N4OXNSS0YyMkFRVGhsRE90SEh1?=
 =?utf-8?B?RE4zNklqVHc5THM5MDIyTGh6L0p1eG1XUzhaK1Rpejc1MVRtUndoRU1wNFVB?=
 =?utf-8?B?SWtOdEZGQlN3d2NybXlJaUd1czZNOVZiU2ZWM3ZreE92YWQzeDB5MjBha2dM?=
 =?utf-8?B?T2Jvb0VTRGlhdEk4ekZTZkUzY1ExVjBiM1dSUmdpdnhRdGU5S2FDblFKUGxH?=
 =?utf-8?B?eGlBVEJWcUV2NFVRNEJ3M1pqeE13U0hRemhaMkNUbTlwS0FQeWhDNDJrUmZw?=
 =?utf-8?B?NW5LVTBlSU4yTlVHOFdLK285RTlZbEd3ZHdQNkdTTERGN1prNmRUdVgrR2tV?=
 =?utf-8?B?MW9aZU1Pb3V6d0ZySmYzcGNRNVhpc0lhK285UElvK0ZUOXlJT3pVM25kOGpp?=
 =?utf-8?B?SmptOWU1K2JtU3JSTDNlbVM5QVU1bXJxTTN5ZzNKMG9WeU1lN1ZxU1YwbkNG?=
 =?utf-8?B?dFIrZVFHUURoQ2NoN3dmcDNkdndEUmVqQW1qeTZ1dG5BbTJUTUEvMG1aYUZt?=
 =?utf-8?B?dmdJWWFXL3RnWi95NWpvTEFLU1hSY1NEWGVGUVQwZU54cGpHQ2NOL0ZLZUc4?=
 =?utf-8?B?VzcrSHNReVI1NmhtTzF1QTZYcXVNVjAvdkxGQkY2SzBscGE2UDBjREgza2Zi?=
 =?utf-8?B?S0puV2xOZndHUFVFU0JMWjI2cjhHeEkwWERMa0ZUdG4xa0QwSUg0VnhMYkhC?=
 =?utf-8?B?NEtEY2Z5Y0tMNmtTaHltQXhyVXEweXVoRnp5ZHNGdzFnRFp4TEx3cnFJVS80?=
 =?utf-8?B?WWhwaXhCNFJMem1rN2JkbzVOQXI4ZUN0bVZzeWNiMUtGS0lYWGpqZlNnUE5Y?=
 =?utf-8?B?TTArTXEyNDdsZ3REVGNGejgwWUYvWWh4ZFJpZ1F4aER5TUNnTHpIaWRQMFoy?=
 =?utf-8?B?R2xvSFk4V2NUNTdGRUk1TnlKWmZLZ0YxQWhYQWI3OTlLMm9wOTdmYkJ6MTBw?=
 =?utf-8?B?QnFNSEJCTVRUYW56Q3lPMTBqNmVJVGN1cnVWaVdhR0ZMeHFCTEZhNGtZS1ZB?=
 =?utf-8?Q?dSOMwSbxYEg1WwzV+A/oFBkyO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6eb1f19-6436-45ff-d8d3-08dd141e5e60
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 04:44:42.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoMJfaMEgvONhBYrx4ang1OcRNEIx96+bJVYOh9gteajBJwM9Pw865QNQgiWgodiqqP0hQFZ6BknMSMB8WWB8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224



On 12/4/2024 8:31 AM, Andy Shevchenko wrote:
> On Wed, Dec 04, 2024 at 10:07:16AM +0800, Huang, Ying wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>> On Tue, Dec 03, 2024 at 02:26:52PM +0800, Huang, Ying wrote:
>>>> Raghavendra K T <raghavendra.kt@amd.com> writes:
> 
> ...
> 
>>>>> git bisect had led to below commit
>>>>> Fixes: b4afe4183ec7 ("resource: fix region_intersects() vs add_memory_driver_managed()")
>>>>
>>>> This breaks you case, sorry about that.  But this also fixed a real bug
>>>> too.  So, it's not appropriate just to revert it blindly.
>>>
>>> Linus was clear about this recently. Even if it fixes a bug, regression is
>>> still regression and might (*) lead to a revert.
>>> https://lwn.net/Articles/990599/
>>>
>>> (*) in general fixes are better than reverts, but depends on the timing in
>>>      the release cycle the revert may be the only option.
>>
>> I don't think that the timing is so tight that we should not work on
>> proper fix firstly.  I'm trying to work with the reporter on this.
> 
> I agree on this, please do.
> 
>> BTW, the commit b4afe4183ec7 ("resource: fix region_intersects() vs
>> add_memory_driver_managed()") fixed a security related bug.  The bug
>> weakened the protection to prevent users read/write system memory via
>> /dev/mem.  So, IMO, we need to be more careful about this.
> 
> My point was that the regression is obvious and it needs to be fixed.
> That's all. Revert is a last resort in this sense.
> 

I agree in general to both of your comment. (i.e. since this bisected
commit had security fix, we shall try to get better fix than a close to
revert).

  I am trying to work on this, but it is a bit slow on my side.


Thanks and Regards
- Raghu


