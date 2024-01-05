Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8682D059
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ehDekRhm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0KEfQGW4sYBROqmP/iZHFSPjKO/1OCNcwUogE3aLGSAIjbi1jMzZDT3nBszVLfiKuijwjoJ9noQJ/p5c1pb4OhUsnwp0u49SBcLs/A2F1vr6M+9wBZ6pGJiRwUjwlHoWOLxYnNs1TsOWWd51is9jmMzUdmXZ593FYNzpGF4F+cAcx3OGJd5DN4/8W3BaVHECFT50Mnpr4yCDDAMDmFtIh3hurFxn8+41deqb1qscfNDX7Qp70iuH+YmhiScSpvEzK10qhW11INVXE88lETyeHVUqmABClHzmX/hEA7Hy4UMmAI2UuFdzHx5fdMmwuGFSlF8MHZx2oBw9RX0E2cixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbDPsbhVvV1OE3Gj74hg3kllMjCpn759ovFg0wFr+n8=;
 b=j927ze7G2fh+XBdiFSEXw5yaElly/Nw3ACz30jortF0k9DOG/9wJ4uBP43+DjzRadpF2T18L51ewf5+csWAo0lKqdy+NMtzuuGCnxa/sz/oplxm2djA69i7H7P1Sy+OWevWKDDZiKEWQSyxqt+8aa55CDIjyWFNmDGzKvikeDDtw4TB9A6WvXEUdPCK7jowW9oxOM0+vrd/U2z9lw+LiPbBwce5Gs+1PKq96kA52jIwMDpJDcbu+E+kcPGXEDlNP/TGY1N3Uu2bCXIT/rDovi68TW0UK4zWwFzjQ1gCkTC0JgsqcYqT8u+V/Ub94ZStORmbZtR2E16hych2hAlc+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbDPsbhVvV1OE3Gj74hg3kllMjCpn759ovFg0wFr+n8=;
 b=ehDekRhmoDNbMhBnzm0RiY2BZPtI5WhFWm7kTZvopgYlSZnkBDSMvF7wpKzcIekIJPP8qYHoa1oV8YwjDUqiYf8yKihhl4kbWByt4w8CQ/XYPdZyyZU3JBhEZBrAZYWPxF8wAC9pvJKOAaymlkuGpCk3fOV54C/0yi0VskDLfoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 22:15:00 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::e46e:7c32:7556:fae1]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::e46e:7c32:7556:fae1%7]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 22:15:00 +0000
Date: Fri, 5 Jan 2024 23:14:54 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v6 1/5] cxl: Introduce put_cxl_root() helper
Message-ID: <ZZh_Xt1RzykFGzGo@rric.localdomain>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170449245417.3779673.4566146351673989387.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170449245417.3779673.4566146351673989387.stgit@djiang5-mobl3>
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BL1PR12MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a0ae6a-cf54-439e-fb95-08dc0e3bc211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tdDhdgsAV1c+r6vW9i3oDTKFTej0GRVPhTQagOTOXAyUsBab3I3/7N+yQOqspKsqLz+dZq5di3FJTaHG+y2RPAU5i3vksBayo9YZq4bukZtTZVuvUdkjA0oGca98lp3iUqDl4xTiTFflZMY1MXB3K6T4Svv73W4HoH4Z1d8/RFTfQ/WKJMTSTttL7dbBWwVIyb5hswwM1q+wfiB57WRUnEVKEbPdlXWhb768v3ENkEF6M+8tf0cf1iYPghP1APLnu7SMWr7X2uOC6V25dlY/U86OBJqg9+vwrQd43WqMvWZDogA75KWHvOh0/Z3JT8qeCYCGMLwl0zD/rI+AJxC1ChNtwZD2d2SqCPBU/mvxELKGJCCb7dndPZDFsVe2BIEe6TDUUBl4Tllh4u8RIOjEzeAlU54W5a6sBoL05P3Yx+2RovTUCHkpB4nS276JvWTj+vElCDGF4KGS1oxkJ5AWnmE88PNPRlm8stp1s0lRUtHbo/9OZPwFHT/9MrYcK+BF9sUkIeNrQioQW4WGomo6djoVKP8Xd2pi1nszusyDkcn/K72XEbvq2i7pyeJF/p2G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66946007)(26005)(38100700002)(6512007)(83380400001)(41300700001)(5660300002)(8676002)(8936002)(6666004)(2906002)(4744005)(316002)(4326008)(6916009)(478600001)(6506007)(66556008)(53546011)(6486002)(66476007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OiF8AHR9lsLVrNKRjcGy9OuLSBQEl1bKXYIAbgQoPOdpVeCtCYzDQMr2ojuv?=
 =?us-ascii?Q?PQ05aeDjQRpCkALRHszhxFfmOCfb9a9P5b+CNOXEItGqYD9tFLvb69bknFRj?=
 =?us-ascii?Q?FeuNPyuHcoM32QUFgSFtBAEiUxIy48cI/X5+tVvzaI9Z8utSWzTcPEW5MawX?=
 =?us-ascii?Q?RpXuqXHjXM/Q1lNbf9406meAJHPjDX9Wtrj4iw9OXmEg51HGLlIoL9a18Mbt?=
 =?us-ascii?Q?ek6zE3BqkxNE0f6M34VtiDYcisedmDIIL5Jk8t/zn1nhKUZUGKg/R6ukHnJs?=
 =?us-ascii?Q?Brm92QoOWMW9d1UShINRz3du0OR632Qwj91pRUhCFSiPh0IZ7RvxHLZlOt0l?=
 =?us-ascii?Q?IAyIXj2afQ7H3XRqBEzCVh0lAYt2gNC24EHn3KybXa4QM31jDJu7ICMFvL+I?=
 =?us-ascii?Q?c51rS/OIENGwLdmsCCVTnPOSAkSka1l60ekZO205O+cUh9U0rvUSF/LPfgsj?=
 =?us-ascii?Q?O6WUJ2nTdyel7OmyBn/iuxPZrO9vG+A7Yk/ZN2ACVW4doHtIDUIRZwkICXTm?=
 =?us-ascii?Q?YEyiTS87ygpCWAiijL32+s4snTZp/9JRGhcJ4XnAEcMuG6ZKMXtjXJNlvJwn?=
 =?us-ascii?Q?1r980bYXENhIsvkf7h939iAm46Xhk2EMGZqeKewI+3jIZ499+vQ4osSQJNK/?=
 =?us-ascii?Q?2bGLeauyE8/9zRlTXhYRp5BLlDNlNrko2ze/bO9g5dI1TjPH8vGUNbAlvFb9?=
 =?us-ascii?Q?Hjc72DP2CghxCiuyaEGBeDNPK4+wauWOJoYCrVZ8n4NBT7+zr62dMQMLFQYR?=
 =?us-ascii?Q?kNjKglcTj9FKBHu8HZE6qBOZ/M4conPGI3/abNYgQ58Tk/mJGXBqLZ+ReZ5U?=
 =?us-ascii?Q?2F3t/I4CPmCd8CQj9iCfF35rq0n8O1C21IVaIq3mJahElPAvOYRmphTpQI8w?=
 =?us-ascii?Q?WhBHZequ7LGe6bkUPOseMoOudDnOpZe8aUc54+XTyzCMCTeLu5+PJb1PTcL+?=
 =?us-ascii?Q?H1rnfGLMtdZhk6WkstpsH4PemfwtfqpS+6LsqZJJcJq3wjO502/qVU6TLuRP?=
 =?us-ascii?Q?Ul55mddnwbfoMDpb+U5BvUelRdSxCZLVNI7gzlm17CGGpAPG39yBK4fBd5cx?=
 =?us-ascii?Q?h034oaG6CylS+t5Gy7+2XjECaguztk8J4rFWp+0cm5OBHYdA8SHpWtCjr6AS?=
 =?us-ascii?Q?O17rLL/mwyLFGhT0T4QzI7nj0V7V3SAvi7CgEaWN4F/9HpeT85zSDZnx+NZV?=
 =?us-ascii?Q?vm7hhMN9HTB311PHBxMKx6oEH5pSAHUM3uVxBZwejFaepq1ueWnKQ8OXhRM4?=
 =?us-ascii?Q?2K37wMr4cfx/npMbqRGPfYh4go3/qQ4BSN7BL+CbpSpwuj8RLSupk1VaOwBj?=
 =?us-ascii?Q?hpH0uRb0R9TtMEmaAXSALPAfH34rlEZJx3TLfWKHjBynCmKzdWEP4+bdgBBH?=
 =?us-ascii?Q?qj5IHz1me8mjfbNYo8XtU+80zEOzEjEN3fSW28HkZv1WftHxzVwD8t1U98Za?=
 =?us-ascii?Q?mrnh/Xdm9SaIHoZhXRSTY18MK8vKX0sttmJMwtNmCGWDy9pI5GAKbQa2UYAA?=
 =?us-ascii?Q?V38Z62h7j4mcptyBRaEFKoj/9Cz3EqJtTM4BKzGq71/Ea4PmclMj7iT32XWn?=
 =?us-ascii?Q?0gBnYJHS+8VmrRc0ihWkR/pVOqC2dA3DyB3pDtF5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a0ae6a-cf54-439e-fb95-08dc0e3bc211
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 22:15:00.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deQo0eUgACdw6YrnVdHLVGzzrWGvmJQ6LCuBUEbZKEb8LN54/p+DWhsT1TGW0Jbi0g4Xkf05r5JcGfmvkwoyKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350

On 05.01.24 15:07:34, Dave Jiang wrote:
> Add a helper function put_cxl_root() to maintain symmetry for
> find_cxl_root() function instead of relying on open coding of the
> put_device() in order to dereference the 'struct device' that happens via
> get_device() in find_cxl_root().
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Robert Richter <rrichter@amd.com>
