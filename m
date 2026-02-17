Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A90271450;
	Tue, 17 Feb 2026 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363666; cv=fail; b=NhQAdCTbY3QN+uhJ2cgAbdzSiqbrBrrCO5v6sZgFANm8PFlr6eWu3P+o0XD+DPa46IvYxdtbJNfZWQgsAd1XSPKLgKXJxXMm+YCX/PMb1xEegJwIkxXUZ06ZEtt1xE5foZTJje9QfRJ/ZMNlOzGFibJOsxAQmdz8DGvVo6+lnLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363666; c=relaxed/simple;
	bh=whVthXn+BTnjbR+WPObxDx+ilQBeRhGDr71pI2BFJig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XiPomlQo8XTcixXTOp6xtX3SnU9s2zQ32ELzEo5z+E2aiYazeWnAQ/TcwXos4MT9Dgl0onXLHvCyoZ7ztrtgPgL2v3lBnAN+M4cEf1XmRJqfd4LodpHJyCByDDMGtz6HpJwC8wonQiXbwgeffDv+z3og6GO5lfMICHOn5xqMF0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SMtZd6XB; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SMtZd6XB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usb3VD3cxDP4PLRBJpO9Sx9pa9jK2obPtI1mafqkmvLZXsJUaW0FScVOLMObiNN1N7sZx5b2uHpvlFeamDsZca0QhGY20eudc5bT58JAmpC/kBq08+Tys9CQVoI7TqpRU5D7BYagcg0v+/UUvWRg+XricMMZcaWo7Q6UtAgIy3hjMgA/W/kbyepf2Nd0OG+x3YG8CLwIFKJO2zXsaX/RHLY/CKBYQxV1qY6HQ8mmmlPbQN9Teeb6C8rDaeK63FeG/dqMs7yNSp9JXp/2i/L7eQkgHYdSm+TBR98TfOf5TzZ88tAyk8n09Je/CkSY4W2cXn1ukz4h5uGTk3lCQy5h4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF8Xw7ydAaCahvIeEJhByFlwzoqpEcg5KC7CGHeWSvM=;
 b=cZ1EBs4TP9jLA7k+eI6yHr/iX7u1q0PqtyUf6EJwsApRIk2egPEc3ei0wenkmPP6I1IUCTRGmySHOwI7CMX67cGH915wCo0N5xvk2b3oo1LNQ9BteP++L0/XOHZcIoHPp8jgM+qyzgIQ+bsr0nT1aPr31b09O5Mx3py4PwFJtdOwJQ5WAV+/Ga0vQlTnM8YpCBif6PYWjk7D0nDTFB4knSxg8nhcM5AJvy6rgdpXzfoHrOF4LmMOCSN/tU7E3FzSLzr+7sgQCirpp6gPj7dAHhLSRPbXQ3mq8ixMdN1NdVtfxLshQzTMarIbNPE1dzlgL5j8IDwC+Sob67WFX9g9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF8Xw7ydAaCahvIeEJhByFlwzoqpEcg5KC7CGHeWSvM=;
 b=SMtZd6XBFQ/I4zEYHLtGu13lC/fniRxcJxOq20LO1TzEm6Fm2YYD3jERQBbRzdFEIRvHGZE/stl/aCZ45MwX+JdPs69heJYJpKCKU9tffV1RzOx0M6BKjQ+fBRLBF+1P8wlspcjwM3xM1Y1pF9izHdRh5g/UbO4N+w3tU7WXLCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 21:27:42 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 21:27:42 +0000
Message-ID: <67e36186-0c54-456b-adc6-5ce13f756e28@amd.com>
Date: Tue, 17 Feb 2026 13:27:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Avoid DVSEC fallback after region teardown
To: Alison Schofield <alison.schofield@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Terry Bowman <terry.bowman@amd.com>,
 Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>
References: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
 <aY6pTk63ivjkanlR@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <aY6pTk63ivjkanlR@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::40) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: b26a2f9f-036d-4a07-9263-08de6e6b6229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnJ4cUVWTUdxd1FNU3ZZaDBBOXBSV05yVXNTY3FsK1ZxWms3dWhlVFphMVdp?=
 =?utf-8?B?MmRtcTlQVy9XZ3c0bXIyY3VSQTBobFdQRHRIdklHU2NLVHdBUkRqWXpPUXha?=
 =?utf-8?B?dWpyZTB2cFRPR3Q2SWgvVTk0NFhaODFVV3dRaTNmZjdFOVgrVm15M1hsYzdx?=
 =?utf-8?B?SXdIdVE5cE4xak84QTVzOUVZWEVucXF6MXF2bkVEVFlkcnN6cVhFWXhaRFVa?=
 =?utf-8?B?bFJNUzNreHAwMTQxZ3VONzZ4YjgyejdPMWhyU2JwVTl4T0hSa0hpSHNUbFly?=
 =?utf-8?B?Y04wNlZuSWwxdktJemE2L2pwVmkvWU1wTE42VTF0aEg4V3ZibVlzL3Q4cGJI?=
 =?utf-8?B?QktMRE1PVW9YaHNkR2FqR2dRNDFhRFdXR0dabXBiOWJsWExBTFRhblhGaG5I?=
 =?utf-8?B?T2ZZZEVjUkpvd1pXb0tTVi8zUGRQZHgxOGIxUjVkQTIvYmxFVVdtditib09a?=
 =?utf-8?B?LzhIL3QzeDRybGFJc1BQNjIxSnV4dkRaYklFTzlBNGZPNFFySmtDWVVEbHpB?=
 =?utf-8?B?RVA0ejU0N204dWp3Zm9uZmoxMnRlSmZPRlVIV3k0Mlo5QWJpV1ZFdDE4YU5C?=
 =?utf-8?B?NGI5Ump1bFdXMWp5blJxY0NrVjdFQmEyYkMwckJsVWE1azhnODlPQmtjWXBI?=
 =?utf-8?B?b3RpOXpaVElOaDJWeU4zcDhvcVp2enhVTThtYmNYY3hXNEl4QWJ4cWRuTUl5?=
 =?utf-8?B?RGM3N3p6M0JrOFBSRHliU3BQY2hIMktianAzL0NIUHlYM3RnU3pERGhyYXlH?=
 =?utf-8?B?MTFXTjJOd1plYXlrdDNxZGZmVlc5R3htOUk2WDJwRzhEM3Q2Tk1tSzZTOXhs?=
 =?utf-8?B?dGloMEFpeGFVSEJQRUNOT3VzMWc4WUJCVW5zaEZFd0svV01JaGcwSXlLRTRN?=
 =?utf-8?B?VGtmbFhSY1BwMFRHK0tSdTBWdi90cFoyN0c5V2UxVHVBSW9PZ3IyclgyOW5w?=
 =?utf-8?B?L25qN0RuTEh1emd3T3dMWktwaFZhNzFScEN6T3ZrZG8vR1FxZkJQL294MitN?=
 =?utf-8?B?MzdndXlMUVd1NzZuSnY5cUVXQ0djdDNPMVZ6WHhYNThlamJyQ1llRy9idnoz?=
 =?utf-8?B?ek1raG9MRXhrcDhDbzNYdFBMNVk1SVBEbnI2NnBPaFdlUUMvcDBHVkNYakZZ?=
 =?utf-8?B?Wm5LSnRYYmFaVnMvandTeGdUOUJSdXRTV004TWFMdHZlU2E1ZjAxSTd6cDZM?=
 =?utf-8?B?VWllMVJ2NkRiWTBJVUF3dWJDTEJZeVhLUGNLbTUzZi9EY3U4aVV5a0NCN3pj?=
 =?utf-8?B?S2ZjUDZkQWtyaVlCaUdpMEpZYXJnallpampDRmdyZFJkREg5WndLSlhlOXNG?=
 =?utf-8?B?anI1Y2oyTGUrZmxSWW4vWFBDWHRmamxHSzh5bHpFNzlnbFRHakZjY3ZIWEtp?=
 =?utf-8?B?WWl6aGZvUTFWQ3VXUC8wbXlUVmxRMkxPV2lOWXRoWEdVOXdmaWwvcVdEWHc0?=
 =?utf-8?B?QkJHTmJEeENXeHJ5alQrcU5QVHcxdEZjbDdvLzZmcTJFdmNtanBsRkFhM2do?=
 =?utf-8?B?V1A1WGd4bGl4U0w1SkRGbzFOTjgrMWFmSUVaVjY4TkczZDhLaUhoLzlyakpn?=
 =?utf-8?B?RHZnVHpwb1BERjErSy9BdGpQbllWdWlNZkZVUTVWdWsyVDZxc3YyZTg1MnYv?=
 =?utf-8?B?RENuL0xXTXcvanp2V1hRWVJuQXlKWnRHM3BacVZEMlZodDVoOTNMS05aRFky?=
 =?utf-8?B?aGlzODJXM0xNYlkvUXI4UlFMWVVBMHRMOWZHYittQkxiZkVLZzdJclFoazlB?=
 =?utf-8?B?blZUUUR6eVJ5Z2xpNEFNWGt3Myt3dlVYR1hQOVgyZGpESGlYYmN4cUp0OTZn?=
 =?utf-8?B?bzVJdTlodUxSTnNiRXVoYmMwT2U2YzNyTTE2Z0MwRUkyUWNPZlRLVWJRSXV4?=
 =?utf-8?B?QjJCdXhjTVFscjZHVjZnNGhqbndvd3ZteXlTMk5ZbjAxRUFVZS84cy9ickFw?=
 =?utf-8?B?bGZJUmp5QzJvVFU1Y0VMTVNwbDMycERQZkhTL2RzRzZJblZpWmEzQU1mcHlB?=
 =?utf-8?B?dnY5L3V4SkI1SGxlTSsrNlEvV0xZR3FWUnNBd0hEOVNVdkg0N0daYWhPam9H?=
 =?utf-8?B?aSt2cTBiZVA0Rk41SHVmOVpzMkg1K25KSlBHN1Vpb2d2c3ZlbnVpcE9qQjZz?=
 =?utf-8?Q?KEFI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enBsVzNTTkMyOC81ZDNoc09HaCtOYXBYQU9qZC9zYnM1SDIyVWhZSkFxWHhL?=
 =?utf-8?B?UVJOUEk5NzJmaENLU2ptQnVtZGdhSmFYQmFBS1lZb3lDc0cwSnd4eFFpemNt?=
 =?utf-8?B?WWxNRmlMNDdaVHREeEpla3RzbGFrdDAvcS84VnlJKzIxd2pkY25LUU5ZeWhZ?=
 =?utf-8?B?dkxud3RwTStySHlsNis1SUVHakRqbXV3MThCVjNla05IR2ZyalJXV2RTUGlG?=
 =?utf-8?B?clE4Z0dhVC9SOGFBcW1zZTN1cTFGa3ZGOFFpcTJ3ZVNxY3BLRzU3aUN1aFZ2?=
 =?utf-8?B?Sit5T2RPL0dPaStIMHlOUlJlMWxTTUMyb1ovZ3RjRldQZTFRQ2pLYkg5OVRt?=
 =?utf-8?B?bmJpK0R2NUl6T3lveldKd3NyVFFGS050QjhqNlBaWVJlSkc1U0UyVzdzR0Fv?=
 =?utf-8?B?UFBsNlM4a1dCMVRIMDBQWFFzajBBYWhnQ1piazB1alhNNkIxdEgwOHU4dDJr?=
 =?utf-8?B?OEFrOE9raWFDNG51MWtaZThXYi9qUml4THdnTnZscy81OGp4cUFqUWVYSitC?=
 =?utf-8?B?NlFJUk5STHNpTG5kZTlrV3lSUUVXUzNORkZOSHdaTFJqUzduMlFNdEluaWlG?=
 =?utf-8?B?WlhTeUZNcE8xQU9uVVdhdmw5bmwxSFJ2cW5OZE9PQTVud1cwMEplWnpiZmhp?=
 =?utf-8?B?TGZPcHQ4Z3ZhdHFwVjd4OWpnWkM0cktjS0t6MFl1amRCS29LSHJSUXZuYWp6?=
 =?utf-8?B?cWhsS0pLNTV4cVY1MklzKzZ6RjJUR0NJU1lqVHlySEYyVFR6UEgwWVRpVUpt?=
 =?utf-8?B?RzNUMEk1b212UXQxcjYvUlgyd1YvN05TcjFqS25EUHZ1UnhjOVBCODBSbld5?=
 =?utf-8?B?OUJzSXhJQkd5czJQRUpyem9wVG5oTkFSeVRDcGh6MFVtM2s4ajdENE1mZytu?=
 =?utf-8?B?UVY0ZkoyMXl5cEVUQWE4SWJ5ZWowdFhnSTA2d0pTTmlwWHB5V0R1QWdPeU5D?=
 =?utf-8?B?d1NKeGRvWXBkK0NGUUxmVTgvN2Z4aDNSaVdsQlBJQlFkQVUwdWxOOFRDR0da?=
 =?utf-8?B?QXpHSEU1L1pUSVJDY0ZzemxUWXpWTGxLQkIxYTYwVXBKZUdVelpFOWV2RUs3?=
 =?utf-8?B?bEY3VS9kMnBiMVNzVGZtTHJRcVJON1U2N29SaStkOEJXc0Z2TFhaOHVkMGty?=
 =?utf-8?B?aXNOTitEU0NTbVpCZXBFRjNkUG94cTlLUzdiVlJ5Q0VPaERJYUVRdDlnUnJZ?=
 =?utf-8?B?V3dJM0h1TGVKNUhOemsrR2IyRjVMVnB2NWhKYWVGS0kyNkJUUXVxUVZCak5t?=
 =?utf-8?B?R3I5NHc1ODB6NENpdEI2L3h0dDl0QWUzNEIvWVhIc1BVK0RLMzdXYlJra1Jq?=
 =?utf-8?B?aTNIS1lTZEZNT1o1TEtUQURaYWM5UjQyT0dkWjJBMlV3REJocXpWNmdvUzNX?=
 =?utf-8?B?V1ozVE5NRFBUbzlqQVdvd2tmU0Q3SVA5Z1NtRE8zNFVybWo5MU1YQmlrdkR5?=
 =?utf-8?B?S3BYNmxBV29LM3FOdVBpS3puV0Y5MmRGSTFpZHpwNXVRN0s0Q0Z3K0pkTjRa?=
 =?utf-8?B?ekFkOXZ5STN4TGtlNTR4c1BSU0FqeUFRZmUzQ0poTGw5bFYyUi8zd2xyc21X?=
 =?utf-8?B?bloyTkthSElrS1JPYXh6QUpISkJGTkxVYmpqaWM2dGJKeTFrS3JjaDNQMGlM?=
 =?utf-8?B?a3dUZCtYS1M1dmVreVo1OVNNeW5LMk85TzJSQ3dLNzJzYUtaSEh5NS9WWWVv?=
 =?utf-8?B?QlZMSk8rU0d3cU5RRWMwQ1pzeGdSZ1RFT0Q3bUZTclJyRlIzR3VXZXFHc2pH?=
 =?utf-8?B?VnlBU0NIaFZLSkhLc1Q4U0k4bFhhOGN5TnRUM2xab0F0K2lDM1lsUjIrdUh6?=
 =?utf-8?B?MEFOSmo1OTZyQTh3R0o3aTRENENDQlBNSzdWSE0zMDdLL3JXM2hRVjVaRkNH?=
 =?utf-8?B?T3lNVnhSNWRrMngrRU9YZjM2c1hUaS9zcDVzUFlOWEc1NmFMaXB0dXVXWEl3?=
 =?utf-8?B?M1ZTc2k0OXRud0Q0TzQyTU9yY0xWSnNIZkN4V0ZtczQ0bTE2RnlIRm9MS2Vm?=
 =?utf-8?B?TmxBdE1FKzhleU1KdjdndnI0MmF1ME9ZUWxRTFZtTURVRXV0YSszQkMxYTNu?=
 =?utf-8?B?ZWJNWVptOEY2a1cyeUsxRUNJNDZpalNmVXNDTFZhN0pQQjUyM3hVdnhuMW13?=
 =?utf-8?B?WDRqVmdwc3kxT2VLUFFsYklzandaNTNsNUQ2V3d3NHpJdUMxcDhiSzZwNmt6?=
 =?utf-8?B?NXRaRHhrU0o4dnpmUFR0aVp2MHJXcHJLTEw0RUxmYnR1eExhYzQ0WWNDWHRw?=
 =?utf-8?B?T3h2RlJaTjdqcFRuRU1OeGM5RGt0NHlFYU1ZdDlSR3lxWUw2WjRpNWp0ZnYw?=
 =?utf-8?B?dTA5MmZOZVZSTklCR0FXTVFBaFdDbWpLWDcrZVJIWFFoSkVueTZWZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26a2f9f-036d-4a07-9263-08de6e6b6229
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 21:27:42.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xc4I7FCD8w1+jgtK+8FW4wz3/z2/dpMo19MiBunu6xIxz+H7gSrYg2lwOB9DnbRsPQsheS7AEPpqaqnst6tnbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364

On 2/12/2026 8:32 PM, Alison Schofield wrote:
> On Thu, Feb 12, 2026 at 10:38:00PM +0000, Smita Koralahalli wrote:
>> After destroy-region, cxl_region_decode_reset() clears the HDM decoder
>> registers (base/size/commit). If the memdev is subsequently bounced
>> (disable/enable), port probe re-evaluates decoder capability via
>> should_emulate_decoders().
>>
>> The existing logic checks each decoder's COMMITTED bit. Since those bits
>> are cleared by region teardown, should_emulate_decoders() incorrectly
>> falls back to DVSEC range emulation, even though HDM capability is still
>> present.
>>
>> DVSEC fallback marks the endpoint decoder as AUTO, which triggers
>> cxl_add_to_region() -> construct_region(). That path copies the default
>> interleave_granularity (4096) into the region parameters. The resulting
>> spurious autodiscovered region consumes the CFMWS HPA space and causes a
>> subsequent create-region to fail in hpa_alloc().
>>
>> Use the global CXL_HDM_DECODER_ENABLE bit instead of per-decoder COMMITTED
>> bits to detect HDM capability. If the HDM decoder block is enabled, zeroed
>> registers indicate teardown, not absence of HDM support. This prevents the
>> unintended DVSEC fallback and subsequent region creation failure.
> 
> Nice find Smita!
> 
> I tried this out following your recipe w an auto region:
> disable/destroy the region then disable/enable one memdev.
> 
> There was a problem before the patch that went away after the patch,
> but the signature was different. In my case, the endpoint tried and
> failed to begin construction on a new auto region yet still blocked
> recreation of the original region because it consumed an endpoint
> decoder, not the HPA space.
> 
> Memdev enable led to this:
> [] cxl_pci 0000:da:00.0: mem3:decoder12.0 no CXL window for range 0x0:0x1fffffffff
> which comes from cxl_add_to_region()->get_cxl_root_decoder()
> 
> And then the original region fails to recreate with:
> cxl region: cxl_memdev_find_decoder: could not get a free decoder for mem3
> 
> Did you see any of that or totally different messaging?
> 
> It would be nice to confirm any varietals here and add useful signatures
> to the commit log to help with searches.
> 
> -- Alison
> 

Thanks for testing! My error signature is different from yours.

In my case, the DVSEC fallback triggers construct_region() which latches 
the default IG (4096) into the region params. This causes an IG mismatch 
during target setup.

After cxl enable-memdev:
[] should_emulate_decoders: cxl_port endpoint6: decoder6.0: committed: 0 
base: 0x0_00000000 size: 0x0_00000000
[] devm_cxl_setup_hdm: cxl_port endpoint6: Fallback map 1 range register
[] add_hdm_decoder: cxl_mem mem1: decoder6.0 added to endpoint6
[] devm_cxl_add_region: cxl_acpi ACPI0017:00: decoder0.0: created region0
[] __construct_region: cxl_pci 0000:e1:00.0: mem1:decoder6.0: 
__construct_region region0 res: [mem 0x850000000-0x284fffffff flags 
0x200] iw: 1 ig: 4096
[] cxl region0: pci0000:e0:port1 cxl_port_setup_targets expected iw: 1 
ig: 4096 [mem 0x850000000-0x284fffffff flags 0x200]
[] cxl region0: pci0000:e0:port1 cxl_port_setup_targets got iw: 1 ig: 
256 state: disabled 0x850000000:0x284fffffff
[] cxl_port endpoint6: failed to attach decoder6.0 to region0: -6

The spurious auto-discovered region then consumes the CFMWS HPA space, 
so the subsequent create-region fails with:

[] devm_cxl_add_region: cxl_acpi ACPI0017:00: decoder0.0: created region4
[] alloc_hpa: cxl region4: HPA allocation error (-34) for 
size:0x0000002000000000 in CXL Window 0 [mem 0x850000000-0x284fffffff 
flags 0x200]

Both go away with the global CXL_HDM_DECODER_ENABLE check.

I will add the signatures to the commit message in v2.

Thanks
Smita

>>
>> Based on cxl/fixes.
>> base-commit: 8441c7d3bd6c5a52ab2ecf77e43a5bf262004f5c
>>
>> Fixes: 52cc48ad2a76 ("cxl/hdm: Limit emulation to the number of range registers")
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 25 +++++++++----------------
>>   1 file changed, 9 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index eb5a3a7640c6..a0718cbcc355 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -94,7 +94,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>>   	struct cxl_hdm *cxlhdm;
>>   	void __iomem *hdm;
>>   	u32 ctrl;
>> -	int i;
>>   
>>   	if (!info)
>>   		return false;
>> @@ -113,22 +112,16 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>>   		return false;
>>   
>>   	/*
>> -	 * If any decoders are committed already, there should not be any
>> -	 * emulated DVSEC decoders.
>> +	 * If HDM decoders are globally enabled, do not fall back to DVSEC
>> +	 * range emulation. Zeroed decoder registers after region teardown
>> +	 * do not imply absence of HDM capability.
>> +	 *
>> +	 * Falling back to DVSEC here would treat the decoder as AUTO and
>> +	 * may incorrectly latch default interleave settings.
>>   	 */
>> -	for (i = 0; i < cxlhdm->decoder_count; i++) {
>> -		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
>> -		dev_dbg(&info->port->dev,
>> -			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
>> -			info->port->id, i,
>> -			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
>> -			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
>> -			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
>> -			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
>> -			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
>> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
>> -			return false;
>> -	}
>> +	ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>> +	if (ctrl & CXL_HDM_DECODER_ENABLE)
>> +		return false;
>>   
>>   	return true;
>>   }
>> -- 
>> 2.17.1
>>

