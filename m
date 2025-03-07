Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11721CC45;
	Fri,  7 Mar 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362201; cv=fail; b=tsRQeJyARn6FCO/hhd97MYnPB92bfq8camigk5B+6RqFdUqYLxrT8/ROHW4/tKtYAdDCSZNOCnrF9gAg+8ZjRpQqpFG/UEIswRNlIjQ/TUdMvYso18oXt2WiY/0KMYU0Hpes4omdrA7zXx4ND0PglI5E7Uc1XOCtA8baNLwc0Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362201; c=relaxed/simple;
	bh=/lTih/ukr9LgF0C4AR6MQWnyDnmbopQgb1Vjr9GqeW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d7kIfaNUTPmKbNKfakYNB/KEz6h//D7At0MIi+Ff8haPOR3E/YoUlJrpdFSCxflPxI/eHfiz36Kl0b6qf66gm6/iuL1xuGAVFXBKQQUDjx4BzhIwV0sY3YPO70SyUkCjx0R7koas+CWdl73zkSPvSXsEI7Ia6m8fiv1Ah6jgF2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dLtk0ymT; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dLtk0ymT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZOcsCJ3BaickWnWdd3umYSsQApsefYFSHzaQHXMK0JApRRa3BXmf/BXzQ+2lwYp1xkunN9L0WCPNTMArXPHGIJMmAaQ9p9cDuatQUah6wOFbnuaUEp2QrgARgE6WoXMQHRfItrR4O4oNK7Hcnr45ZoEgrkC7TgXU+BSYWny7AcjaczZSdDDgrSWMvJnjZMpqVSQKeeOnCENY1ZUHprKHD65tIHU9l2Bz3w1pTRdvXBdaaAiL1YjfvX27+aRzcndFQy1XNUntmBJ/uD4FnSdwauuXl+gfrEcW6x1EqLpgBds/9pMG5ahYfewb5DT/YXhP/67d4Twxv1hQNUY848FLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZgtcn3ltlBR8Iig91wKdmdCMNzoErKPrW3jIQy7uIY=;
 b=fwgFoR4riSY6PJCK5LygWmz/qqAxmVnksKX5rm67JsMTaEJ30/gNEvDRE51Ima4uRqgCCQ5E45bRs6R+RfWWX+ZdizfPyKdkgGnlU47aRU14mcKXCY2LH7re98r1+8mfS5pgsipI2RJPDm44VIu+mL19VIbGiLM5wHxdWBGo33p1Yjt+FZ+xiYGPLmpJjtr5UCwljb52PbsQAwUgeBDTq0BSy7HLGiDxx0VgJ8MCdWFG17stnLygxw7yWS77qdEfMUX2S2FLETVrxK2CHH+92OtlBNBVQ57rEywOyqni2KFGGR2N9Yl0c7HUmHaGrfUnY9Zne1Drlxy3/X2gwEJPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZgtcn3ltlBR8Iig91wKdmdCMNzoErKPrW3jIQy7uIY=;
 b=dLtk0ymTY+7+c9fonwMv+hnp/voS1CJwwhICOGRYTHOJwMBFvEEzoQRtIZ/RMoDzf2yWZIsnvqo8/fnhwtFMAjtE3UpusVJ3me5OkKBJflQwSntnNvFp7Syso5mBMqQFbvh8V22qyz8nIi/bIolmkK32ympDtOAwNlwYQePOmHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 15:43:15 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 15:43:14 +0000
Date: Fri, 7 Mar 2025 16:43:08 +0100
From: Robert Richter <rrichter@amd.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH 2/2] cxl/pci: Check link status and only enable active
 dports
Message-ID: <Z8sUDKcQ22oBgUh5@rric.localdomain>
References: <20250305100123.3077031-1-rrichter@amd.com>
 <20250305100123.3077031-3-rrichter@amd.com>
 <67c86b9f770e8_77ff4294ed@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c86b9f770e8_77ff4294ed@iweiny-mobl.notmuch>
X-ClientProxiedBy: FR4P281CA0280.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::16) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d5cec3-361e-43a8-4b5c-08dd5d8ec61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ba62OFgryzfGJ1O9eVXiTFjEWoUzZD1jbltMOCmC0xaIDfETKjqDPqk+gqEj?=
 =?us-ascii?Q?zI8b5BFN+2JOnh3sk3ErPFjPA101HAiBFE8iPQ9MPfKO+ZYkjZQcAAA4DV+d?=
 =?us-ascii?Q?Ig4emZ5zYqlOZL1nRWdzW7XSUnQNv3VXd53u7ULSkp4NvZix9+PcGHJUkgh/?=
 =?us-ascii?Q?qrzjFHE3F/WsN1WnkbrXTTOX1HxsACNO9aoQ3820DUcPHcJ9r9sPC1/HzNEh?=
 =?us-ascii?Q?h+lDLPWMk/iBDJITC0rGTOazg4rG/3ZjRDBIO/rXPP3hGWJeEm6zAxCZwmVg?=
 =?us-ascii?Q?dt43Ej0dGyzX8fTkZY0a3MX+gMHTYOgPjG6adED7TissX/uQ6hPig9uApOr4?=
 =?us-ascii?Q?p/r47hQz/3AaTjA5vlDwPsooO49EF5b3sfZE7BlkqtUreKOauajnLv4UIRF3?=
 =?us-ascii?Q?FONcab0XKLq8gLzRQsyM2c6vEThqLiVvgr9AcRSU6ZChrPrTs8X4jfLE3wB3?=
 =?us-ascii?Q?Ug6OWZT6QIpFmW7E+qN7RoPRtDv3yC9Q8qR6VX6WNLoBpuCPva/OmHTRcbc/?=
 =?us-ascii?Q?OHj9QCqDmSHrsnRtAIeAzN7J5bWcezMOnJdYc/28iuemik0MRyPgnu0OgMNj?=
 =?us-ascii?Q?YbPYONJ93WKjNYVwAE9cvDiPnOGIUak53TAOZimv0UAOzFehet01vzXQOek8?=
 =?us-ascii?Q?uurzawBfZ4ffUnR45/L7OEAJPxYxAxoekDuzsdzt0zXyu+sH09yfhGyojLfI?=
 =?us-ascii?Q?3i4f6hdr4+wiC2wQ2imDL2G3Z90bMUMRN0Ybn8YzqqtMhaYkog6MJ+B8YXnr?=
 =?us-ascii?Q?WOsjQdnvDc2gog9uelMEAW2gslfr0hNa9AUc4j8U8GXxO6hallNTIdlEJTlK?=
 =?us-ascii?Q?QF1sXDBIlC0UM2rU0bSEJOsUAqAxqlGOjY0/v8lRqIEG2TuNro99BBLi4CaE?=
 =?us-ascii?Q?W+h0l9KbNTo4U6YZXs2ULy8PahhtYoWgswEOh5jZ8QQ8FvQl4F5k49v3RWqo?=
 =?us-ascii?Q?lWYPbVFxB/fcH8kNUe/f6xt9X+t5MUZT28VChXuSo3D9OuE3U56auxxq/Cd8?=
 =?us-ascii?Q?B5SvY0pjTm/QOFSEmkf0+T0caTV37eVg42/MIdscxpFI6NIbrE1X8mtBr18d?=
 =?us-ascii?Q?0is6Up3D0450Na6QElAAaXsji9943CLm6yYsWrC3C87w0oMH+WSvi7YkRsj/?=
 =?us-ascii?Q?iRZ/cJ4Gkd85LlSE3pJL7dWqwCxsLRqGhJL9FiEBzD7eRm/NHq9f+kaoIzcv?=
 =?us-ascii?Q?eiXXE7lBdNcEB7qyUYH8t40PJkPaf1t6uBEyOtIXYJ9KS+4a+GyMxBrfbFFe?=
 =?us-ascii?Q?0h7cFBXZIC3VrjRfC5GKFml/Fm+GATLjsGy+X8wtJTklw9xYCT7M3SVwALDN?=
 =?us-ascii?Q?RAQ69XDh59vvkIS7Spb48X7FmS70+lJiCzuBKQmBlEVQxOeTyeeeCH7o/if/?=
 =?us-ascii?Q?ASE882S+zWxBqzBdBC9YWjGcq63x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pcA5IF1KR4tMe3k2U9AlWO6Vg8zVp4GsM95HwHo3dooOLMW8R8oy+WdlLEmv?=
 =?us-ascii?Q?jMsHTVmBxucUjjM8+kyctarolrusHOe4AKaeokGQmySj5sf/HBV/GgPLUo/W?=
 =?us-ascii?Q?Kxt447RUrJgamfPKycpv3R6fmDGP3rfktbZfdaiIi4ItAj4AtZZUCue32iT8?=
 =?us-ascii?Q?DNrAXGSX9LqVJtgAEvaHkJ7LNRS1alW2IbqivIa5/32075lkikJKKMRNR1x1?=
 =?us-ascii?Q?7RqMPkpXYz3kP7+HyCRqOL72ZozWVPQwjPRDNvEYvggmTf38YVBrk/s4NKs9?=
 =?us-ascii?Q?CIcHfDuun6tE/DvI6Nlb3AcxmO4jKiFc/isrqIFcZjlnI462vFbXZR2th7tz?=
 =?us-ascii?Q?+/Sp/rWa6P4Zo0toIO5v85Ksk+JrpUOiG58xThu/t/UVXXOCfwIdiTiBFBEd?=
 =?us-ascii?Q?l+UTuwufMvomCzmqZRdeekEHB6IoUq6UXSmxxqxVxE8dKEXeEpcaRleOHRPB?=
 =?us-ascii?Q?zxWhAb/U/9SJpyA54g/baa8Xb9Suh/CQiXgHQ5yOqt5nmW9VS4fdfV4fZK+R?=
 =?us-ascii?Q?FcvHjOM4tv+/f/9Lnc1N/rSV+P86MYWg2fJqKM59HkZklJaZXJqTusFAefFB?=
 =?us-ascii?Q?7UcsZMvUfnXe+GFwC8hreMLX1Cd7xQOVZIrYA0vkR3G3xOUb36B+6EVBShmU?=
 =?us-ascii?Q?2ipZS2dkewL3MprpT0nYAGxFjPxnTVkpU5tKu9tYM6QlqV5NnIOvI7lq3oFe?=
 =?us-ascii?Q?dxZGDxlGTfmjnY//Ztv1wmc0SHt1so7B7ML7s2tqoWn8Yyc3W8NwZvTWiYUm?=
 =?us-ascii?Q?/6PpB1o7/NqqXyvThojmF6s5CGIcdv84Sidja44NsSdOdLn4a51EKO+5KoA/?=
 =?us-ascii?Q?NPyLbqW/DpO7qa4HU/qs3tuXFZjB4hELbonlx/BmMd7ShWHA+O0TRwrz9H2h?=
 =?us-ascii?Q?rhUU4PZW48N3pnG6jOc+vOidJ5tT+wACrI6SzvgUiuTUb8fCu7BgKm+UDoUq?=
 =?us-ascii?Q?H/VGX321oOXF0y9DZWW3kpWMJCgckr0ZV/MHxquV1iMBY2YgytQFY3u1OnmI?=
 =?us-ascii?Q?SCjR69u41NapBUZy0K+KRnHqG7X5vBpPTZ81/5f1hI7N3nLr45LWcH10jBF5?=
 =?us-ascii?Q?5kkIE1Axg+Q10BLNwyG5DSEfUJMaX51jJTrRf3J6hxmKxRJTU6bAgdtGsJLK?=
 =?us-ascii?Q?4tLBMM3S2NxmaeRsXfeXJzv8WCGJE69ky28hw5GzecfRNdbFCmRevzhwbX0w?=
 =?us-ascii?Q?DZCw3MChzdvv7oJAaNf5z51yhZObKODyK+J+mSTUA092XxauPGF36JLBIz87?=
 =?us-ascii?Q?A3VF8ArW5nd+iXBIxG5Opl/t+n912XT9KI3aAM5pySMh1o3HoDLzla+IqaJy?=
 =?us-ascii?Q?2/NfnnAbE4tYsWPbmW+KW7C1OQJr3qEZXoxm1T32hs7zj1EKYhTCRsZYv+J/?=
 =?us-ascii?Q?OGmvElohQq6R5E+V3pqwkVr4GR7YJIDSTi/2MicgRmKTMINGIbu4MhPacAhd?=
 =?us-ascii?Q?DLT/QpyBqa5+yEohkO87oEs/Is1Mcu6VdxZrhcuxYwQ5IEhZwisYhIxKLxpw?=
 =?us-ascii?Q?QSc024ogDRb9navA8vaq46dZu23P3nLxN/jJC5nh2WjZl38EmPSnximuTirG?=
 =?us-ascii?Q?ZoqO4mPHZcpFm1leTuz1hlaPT7GHwoJGoyaleH+m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d5cec3-361e-43a8-4b5c-08dd5d8ec61d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:43:14.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTVGBTNVV4rjp+2Pfu6giV2+4MbGaW9UBUNoA3tMbzcCf6F+p7G1tPMTrIPpDbBaYctG1ZpAUWZQko/c6Y1o6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

On 05.03.25 09:19:59, Ira Weiny wrote:
> Robert Richter wrote:
> > When downstream ports are enumerated, some of them may not be
> > connected to a corresponding endpoint or upstream switch port. The
> > dport is inactive and its link status is down then. For permanently
> > disabled ports a HwInit configuration mechanism (set by hardware or
> > firmware) may assign a (further unused) default port number. The port
> > number may be set to the same value accross other inactive links.
> > Those duplicate port numbers cause the downstream port enumeration to
> > fail including the root or switch port initialization
> > (cxl_switch_port_probe()) and all its active downstream ports.
> > 
> > Prevent a port initialization failure by checking the link status and
> > only enabling active dports. If a dport is inactive, there is no
> > matching component (endpoint or switch) connected to and thus, it must
> > not be enumerated and added to the kernel's CXL device hierarchy.
> > There is no device that will connect to an inactive dport.
> 
> This makes much more sense.
> 
> Wouldn't it be better to use this patch and leave the old error
> messages/failures on duplicate port ids?  IOW drop patch 1?

The link check only works if Data Link Layer Link Active Reporting is
supported. That is why there is the patch 1. That patch also handles
cases where dups are seen that are unrelated to the link status.

> What happens if a link is having issues (perhaps going up and down) and
> RAS events fire for this dport?  Does the lack of a dport object cause
> issues?

Once a dport was enumerated it exists as long as the parent exists.

-Robert
