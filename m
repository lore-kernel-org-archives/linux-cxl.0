Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6B14B064
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305137; cv=fail; b=VyksUpx5doBb9CfglJRcA6Bm+0RqmxE3KZ0aSMhKP//Galb6tQ8iSaf4FNY5LFZlR3UZ3qhugLQGfsjK27zJPpha+Bphlj5OfknHm4/J6cGOfga/KMeCgRo3Jy136A06ni7m3cFkG9p9sfDL6to7U+33FfdW26TuHKRgFEUnA+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305137; c=relaxed/simple;
	bh=VL9dkgenYHrRSEaB4g8v3rr54S9RU9IeyTwFPbrXpys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ky5sGPGx0V9wA/gxe/UcLLETa6Wc2zQkkWzpnPjQ2oGju1wRwkvIDKINOAQWSV04C0lQABDapxjv2pYNvnOwGs92um7JRpGbEnYTbsMbhN158OZDC+z7MqDONLd3GW9WCywCSsMxJGRsyDxESjU8w6DF2QnQ68dvgH8oCwvfpz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OiwNTIu7; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OiwNTIu7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fic3l5kBv5DeLjAuP12QJB0xgy9ptHvKlcNkMRwbHor3j4/B20b6B+YXKr56bxm86l+8LE4WuJCt/RzXCTNg+5owLZl44SDqy6TkrNCyUcf8GKevT3UCLu7I/yUfOQ1gaWX/a+FENGMaiMJhJhAbx293kCGhDeI+oWGZ3kl5FgER7CslnhGOfsNQgN3uSl1dNJ9zFFEzx6l7y4MG8vtLwDI4ifDeyu4MYe5sPl3jsNONCBDD8mSTsxpk9/NlWs+si4+FE9F0RR8dZbZKEnj2/Wr1X+WLHXb52OFeLvfCOQdhjySE5reJVsC/wCGY63DiHYsrX5+bvyRYPm9XSp0Qmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pQgbo3WuGms3jbwb9VPHayGTYfkd5RQXEO7UdsKLTk=;
 b=krlvEqvvJA0pH4DupkB4cRAZuBUtBVwi7/NDx5jgk2H2LES+BN0Zm8edjkVrqQZ1KZgVoul7e5vyYrLCyhB40HGoC8v+9p2XadZ2/2FiesB1EDOxZIAxM4cdqkc5yWW2QOndusFRsiQfCettcHjZ2qorXwSsXLnFSTWU82Bcm6IApJkhEmeqLjEDi1elf/6ipEV5q3K8P2eATfZBBJg36omqAYu6FNtV1DzzhKkQPRgRQowt+rdrbLV9rH2njGZJnUOht8oHFSDfCaWvcARO16cI/KhaZzWiTZAJupBQv/aI6CcI7CeUCGmsUR7/YokNREuRAp1Z4Pnax0nTDDkBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pQgbo3WuGms3jbwb9VPHayGTYfkd5RQXEO7UdsKLTk=;
 b=OiwNTIu7rzK+/iBoE3XRNqThXziC13NawmZmT1PlU/ptgPgNk6fXiT8sb7mDSu5GbVvWeslW2Lic3xzQJm6PHT6uHzx9lRqHK5h1TS10EiB6LehfPsSagp93GhjY/oRIJgm6PGCkmM0B+6WU7v37JNL2tGqVBFHz4jqlQy+w5Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 18:58:49 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 18:58:49 +0000
Message-ID: <34868fdf-2f19-40dc-8ae0-3c5123f3ad1a@amd.com>
Date: Thu, 13 Jun 2024 13:58:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Remove soft reserve resource at region
 construction
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com
References: <20240612205905.1209448-1-nathan.fontenot@amd.com>
 <Zmo9ltXuf5G7/pwi@aschofie-mobl2>
Content-Language: en-US
From: Nathan Fontenot <nathan.fontenot@amd.com>
In-Reply-To: <Zmo9ltXuf5G7/pwi@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0115.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::17) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: e774088f-0e6c-4d97-fb87-08dc8bdadbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0F5YTNtOWlVc3RtaHZPRU16M0lNclZNVldiOTJOS29JMnpJNlVpeHlsWDQ1?=
 =?utf-8?B?QzkzVlFJbVl3Q0Npak1SdmIxV1hYY1krOW5vS3NhaU96RGhvYldJNWRWUFo5?=
 =?utf-8?B?aUY5QktLSVorb21NdDlscXJOYWJkcTl5elZJeVJNZzJTdnVSeDBlTzB4K1Q4?=
 =?utf-8?B?cWdUKy9QSzdYbEZ1Mm9oRFBoenZSRTFRSnN5TitGa1lIclg1ZVFJZ3lJNktt?=
 =?utf-8?B?dmcxTUlXbW1Fb0o2TjdXUk13aVI5ZCtDeHZLOXVCNFhCd3FCY0MxNFNQc1lO?=
 =?utf-8?B?eGNueEQ3UjAvRWRLbVpMUEVYSVM5YmpZZ0RIOWxlMWxHMXQrNkFRSG5mN0hl?=
 =?utf-8?B?T1A3dEF2MDJjSnNXU1Erb25jbjRjZ2dScVJFQW9QSVZDbm5HTEpCdE90OWxX?=
 =?utf-8?B?Ui9OenI0UzJ4ckZtMktXOEZQUTIwVDVWSTR0ZHF2VmJzOVFCdytCRnQ5VytY?=
 =?utf-8?B?RnpRcWxGK1Rqb3hWSURHaU1SWk00WDlRUmxIU1RZWE5SNHdIa3RRQWxUUXFD?=
 =?utf-8?B?N2ZlcTJOVldLbzh5NEtaQmJXRjFiU2ZvYlJWMFJFdTBwSDBpL1lkWjdIc2do?=
 =?utf-8?B?M2tUM2g5Q2Jwb0ZxRFFkeTJkZHNTTklHSk9nYVZxUHE1R1RyV21MQTJvaXVo?=
 =?utf-8?B?VW1xSTI4cUVjdXY0ai9iUFhyVHA2NjAxeGFrdE1FZ2NsNE4rd0FlVUM1dHBX?=
 =?utf-8?B?K2VaMkMxVk9zanRPNWN5SEpwTWhBSFQ2aTY0YmkrcTV1ZlA3b3ZDNTZtaUlm?=
 =?utf-8?B?QjIwQ0hpTGZkWUJ6SmVBQ01IazJmdXZPZEczT09TTy9vQ1NzblNoYU1Fd1Mw?=
 =?utf-8?B?SmFkVytHWXNES2hoZi93Y1BLMmlNN1dmZ2EzRWRTS0U5MW9ZenVidVEyeity?=
 =?utf-8?B?MFNyWmRIQVJFdlZpcElMNVpiYU9PRytiMGpoL21ZUjlVRkVJYUM0YXlGOE8z?=
 =?utf-8?B?eG9TbE1RT2FoQkZNYW1MdkI1eHU2YWZZdWE1VDVnem1GMmlIY0JldnI1RjN6?=
 =?utf-8?B?YnE0cS9oTS9lbFAzTjFhWVNaK2FsdnM1VWhVT1l4OExHV2VtK2RQQUFPRW9J?=
 =?utf-8?B?MG1hcVN0RzdHYVFQVm5hcjlRZU9FYUhLbWZXT09zcVdVQWhtTUlBSnl2ZGNn?=
 =?utf-8?B?S3c1SGM3bDB0cndGTXNkS3Z3VEkwSnhFeEptV2wwb0tnQ01kM29sc2ljblZP?=
 =?utf-8?B?enVlV2NpWmtzM2g3SXJJM1hRU05XR1NEdHFVNWpRWW1MR3dieDlHRjZ0VWR2?=
 =?utf-8?B?UVc0UWdwT1RITC9PSEpuWHFKTnFvTFd1N0J6QXZLMDJVRFg1NklISW84OUNh?=
 =?utf-8?B?dHVlZkJoUStrSnZtUEFvZWhKSnVHU25sSVptczZHakI0S3J3ZEZSNFBzaW5D?=
 =?utf-8?B?bE9ESDQyTkdpYnZaWjhkcmVCZlRndUNjN0FabGVqU2V5NXFPQlJQUTBUSS8z?=
 =?utf-8?B?ZWRqNmZnelZXOGNVMm1FeVhPSDQ2cisxbi9xNHN1VGFob2luNmIwcDhpVWZP?=
 =?utf-8?B?UlR3VUhTRmUyMmNRaWtyRmRRUWRQVEhpdzQ5YllPR1p1WERmTkNjaCs4bEMr?=
 =?utf-8?B?ZHhsZUxLZ0FtVDJjUEMydXc0Y2pXOVlCRm1WOWNqN2FtcEt4NTl2bU9YVzRK?=
 =?utf-8?B?Z3BoUzFncXRITU10emJ2cnQ5R05aVE95bVhDOFkwRTY1aWd6RG9ENGF0UU5D?=
 =?utf-8?B?WUtEMndzaEZSaWF4TzZGNUpwY2Ivc1dBUDJnMUJ0dk9MOUl5dmpWMi93a1hS?=
 =?utf-8?Q?TMlHdFxbJYbNrKdQGpDb2AIp+7jyScb0S5BsGMQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGxyZklYRUtrTjJmZnVGS1BvRUhmSEdPdU1DQVJOQko2ZjR6amVBWDlhZmJy?=
 =?utf-8?B?RkxMUFNBd0ZjN0lqY0Y5SVVNcnRNMmxOcUJlaWVUQW5lem1KS1ZocGlYdVZY?=
 =?utf-8?B?RDVraDFOZ1EyWEdVWWN6K2JJMnNjU3hIQ2puYjYrbFpzMkVYaTV0VnE0MmtF?=
 =?utf-8?B?TkxneGZEU0o3M2ZKbXk1T3NGRjdXS0hmdklaVFNsM01qVWFmTjZEY3oyalIz?=
 =?utf-8?B?SFZCRTZqTnBNNlZxVmhlSnhMK2VDNjNQYkFMSWdScVVqQWlQdmtqWCtHam5K?=
 =?utf-8?B?YXhQRXFaYkw1Z0NERlBTV2dhRWk4cWR5YzdhNVl0RHRha2NpWmFUNHRWUGtj?=
 =?utf-8?B?clhOaC9MUmxhTC9icnNtMDF5RVpGTUd0MGhBbjQrVHJXOWVwRW4rTkxSN0E3?=
 =?utf-8?B?Q2E1aXE4MzgzVVZBU0krdUNpQURSZkRSRmZoRGJEMHdBdEt0WjJ2Sk1VYkZ6?=
 =?utf-8?B?NmtpRHl1WFhZRGJFVDIvby9UdE1CMno2WlRkd3V5WlY5OGVIcTVGNnlFSHFl?=
 =?utf-8?B?R2NERS9mUVE5aS9Ocmh5dzI1MkpjYUVPOUl0bTZOamhyMUpPMGUyd0c0Y0tJ?=
 =?utf-8?B?RlB1Z2taMHQ3QTFWWndmeW84bWlXVW50dHZIa2FkOHRkYWJVWmdFMHpqMFQr?=
 =?utf-8?B?WHk1UCtqMTBIUnRRaGNqYW1RK3YwUTdvYml2VHZ6cDVLMno1cmt6YTFoMDVJ?=
 =?utf-8?B?RVQva1hYbzVpVHZ1b2w2UlF1YjBjSUxCN2Z6MEh0SkZ4TUphVklubzBKL29C?=
 =?utf-8?B?YUtPVEZKOWcyN2N2UngvZElXWmRLMDZpblFqVjFZQkhneEp1bFF1WkU0OWhy?=
 =?utf-8?B?ejFSVTh6a0duZWFNQ2kzZXlLM0ZZajVKcmxEOHVSSVBxdzllVXF1K1ZpUjNr?=
 =?utf-8?B?ZUw4b1pTN3Z4eE1wSlhMRVFJMkVjNEliK0R6SzlDRW5aYmRaNm1mVEJjZUpZ?=
 =?utf-8?B?UnZjTUNZN0FhQW9XbWRjM0ZXazEzMkhxak5oaFM2ZEFrNW9sOHJqdksxWnpB?=
 =?utf-8?B?N0hSeFVESHhHMlpJalo5Rkc4ZmpCSnYzbVFlUWpvWDlqS2NhSFFWUjZ6bytJ?=
 =?utf-8?B?V0h0dzRRVUhpWUd2QVVEcGt1cGV1YXZkaGtESFRLTG9wQXFWNHNoYmF4c0dq?=
 =?utf-8?B?RE1ockRGRlMxbXZIWEx4VVNVTXNKRnhxdCt6MktkYWVzMHBNTmpRZHlkREQ4?=
 =?utf-8?B?c0RWaEhnN3ZXUmpBNXBSdWdUeXV6aDdZN0tVRG44WnVNS243Rm1ZdnhWVnJt?=
 =?utf-8?B?SGR2QUNZNzRDS1FOOFlLMGdrYXVMem8wTHpYRGoySDFjMXoyTFBKRWZZR3ZH?=
 =?utf-8?B?NGhvSnJtOEYzQk1NUkpkSnRVT2xIU041MXF1a1V6Sk5xM09NaUdCZVVpVFdM?=
 =?utf-8?B?MDFUejF5VlNBeHVrV1ROalhaRFQ1eUhBc2R6VWdqY3BENitYRXMvOS9XZlQw?=
 =?utf-8?B?Ukw0K21uTW5wWlRnR2h5dDJoc1VHMG45TnNSZzdjNDRuMTJTM0ViNDZYVVFT?=
 =?utf-8?B?ZHJjSXpqRTUrdElNY2hETzQ5c2prVjQxTktxczlaRitYQVRBd0VuWGhobU5x?=
 =?utf-8?B?L3JFcENyOE8wL21OZjhWdHQwYXU1cVRMYTUvRUo1V1RUbVBobWxiUjJzVWdr?=
 =?utf-8?B?c01rK2s2V2VLM3dFNWR0OVZKYytZeWlXWnlheUMzbisrUytueStodG9TVjFp?=
 =?utf-8?B?ZVYxU2dlZlhvcjV3RjhyWjk3d2ZYWUZoQnRCREhoNVdxaCtKLzZTVzBuZ1lk?=
 =?utf-8?B?YkRUTkpXYlRxZjhPRkFXMXllUDRxU2NEZzB3NDNnQmR0cHlWNTlhZTcvb3lS?=
 =?utf-8?B?a09WWnU3dHBiT2FkNGRuVUpGWWpDamZrNS9LYU5zdDlzNDljSnNoRmNYM1ZE?=
 =?utf-8?B?azBmLzRGWTNma1Ewak1haWVobXJzUUs2dEVGd2RHZFhrMVNudTZvU1MrUVZa?=
 =?utf-8?B?RUt0SGNzVFZldkpaaklZRG13a1BLYUg5aHBhMnhqblorNnFpZmFNcW9aUHo3?=
 =?utf-8?B?M1ljR0VzbzlRSjAzMmxMbXZJRi9laG5GTXA2QUhVOE1OYmE1WXZuMjdCbVRx?=
 =?utf-8?B?Q1dzL0h1M1N4NHdrUHRHWGFTeW4vOEJRY2FuM28xYytrbVgrUFlCVUpZQnM3?=
 =?utf-8?Q?o8pFxyu8fj/NtrVYrJvYU1xOa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e774088f-0e6c-4d97-fb87-08dc8bdadbfa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 18:58:49.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21On1OpYCifurAGaZXMXPvLud9GWGgVEZxRujwO7DOPKNi58jEEcq8eUo6qF8GVGkcusF1iC1KywGSAHK7odPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084

On 6/12/24 19:30, Alison Schofield wrote:
> On Wed, Jun 12, 2024 at 03:59:05PM -0500, Nathan Fontenot wrote:
>> Systems with a BIOS that creates soft reserve iomem resources
>> for memory ranges covered by CXL devices, the soft reserve resource
>> needs to be removed when hotplugging a CXL device. Without doing
>> so a new soft reserve for the memory range cannot be created
>> during hotplug add.
> 
> Is a new soft reserved ever created?  I think the reason is to
> free up the memory for the new region creation, period. If the
> SR exists, userspace cannot 'replace' the region.

You're correct. I had started from an bad assumption, there is no
new soft reserve created. If I now understand correctly the issue is
in alloc_hpa() when a user tries to set the size for the region. The call
to alloc_free_mem_region() ensures the address space is not claimed,
which in this case it is by the soft reserve.
  
> 
>>
>> The previous approach from Alison [1] was to fix up the soft
>> reserve resource at region release so it longer covers the
>> memory range for the region being removed.
>>
>> Instead of waiting for region removal, remove the soft reserve
>> resource when constructing a region. This is done by walking the
>> children of the region's parent's resources, finding a soft
>> reserve resource (if it exists) containing the memory range
>> for the region and removing the soft reserve prior to inserting
>> the resource for the region being constructed.
> 
> Is it OK to remove the entire Soft Reserved when that first region
> is constructed?  ie. in this setup that removes the soft reserved
> before region1 is constructed.
> 
> 100-600 : CXL Window 0
>   100-600 : Soft Reserved
>     100-200 : region0
>     200-300 : region1

My approach was thinking that it is ok to go ahead and remove the entire soft reserve.
I couldn't find a reason we needed to keep the soft reserve after this point. I could
be wrong on this.

One different approach I've been looking at is if it's possible to add the CFMWS resource
as a child of the soft reserve. Instead of starting with 

100 - 600 " CXL Window 0
  100 - 600 : Soft Reserved

We would have

100 - 600 : Soft Reserved
  100 - 600 : CXL Window 0

My thinking is that with the soft reserve above the CXL Window we no longer need to
manipulate the soft reserve range on hotplug remove. The alloc_hpa() call for user
set up uses the CXL Window as the base for alloc_free_mem_region() and the soft
reserve wouldn't come into play.

I haven't looked at acpi:add_cxl_resources() enough to know if this is something that
actually can be done safely.


> 
> 
> one bit below...
> 
> 
>>
>> [1] https://lore.kernel.org/linux-cxl/cover.1692638817.git.alison.schofield@intel.com/
>>
>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>> ---
>>  drivers/cxl/core/region.c | 30 +++++++++++++++++++++++++++++-
>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 00a9f0eef8dd..90e5c84230a5 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3096,6 +3096,34 @@ static int match_region_by_range(struct device *dev, void *data)
>>  	return rc;
>>  }
>>  
>> +static int cxl_insert_resource(struct device *dev, struct resource *parent,
>> +			       struct resource *res)
>> +{
>> +	struct resource *soft;
>> +	int rc;
>> +
>> +	/*
>> +	 * Find and attempt to remove the SOFT_RESERVED resource
>> +	 * (if it exists) that includes the range of the new
>> +	 * resource we're inserting.
>> +	 */
>> +	for (soft = parent->child; soft; soft = soft->sibling) {
>> +		if (soft->desc != IORES_DESC_SOFT_RESERVED)
>> +			continue;
>> +
>> +		if (soft->start <= res->start && soft->end >= res->end) {
>> +			rc = remove_resource(soft);
>> +			if (rc)
>> +				dev_warn(dev,
>> +					 "Couldn't remove %s resource %llx - %llx\n",
> 
> Use %pr format for struct resource.

good catch, I'll update this locally but Dan's response let me know the resource
walk is not something I should be doing.

-Nathan

> 
>> +					 soft->name, soft->start, soft->end);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return insert_resource(parent, res);
>> +}
>> +
>>  /* Establish an empty region covering the given HPA range */
>>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  					   struct cxl_endpoint_decoder *cxled)
>> @@ -3142,7 +3170,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  
>>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>>  				    dev_name(&cxlr->dev));
>> -	rc = insert_resource(cxlrd->res, res);
>> +	rc = cxl_insert_resource(cxlmd->dev.parent, cxlrd->res, res);
>>  	if (rc) {
>>  		/*
>>  		 * Platform-firmware may not have split resources like "System
>> -- 
>> 2.34.1
>>
