Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E6195811
	for <linux-cxl@vger.kernel.org>; Wed,  4 Jun 2025 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050878; cv=fail; b=ldD57c8L7YuduuWbP1phbVfxGS18A7s6YKqM2JCmb/9yVs5dO8uDACsPRkIV9ZNtXgEdf1XC6P+k09ip69dJwbYVDE2Dpq1g793RV3LB4B1LQggNjfJYsW8j5DHWcj6czOPb95pv+PWxQkiEEKgyDggf3Z2UZ4poilWfGUG34yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050878; c=relaxed/simple;
	bh=52NZYWjAIoVqPD9/JUl8BJ+Fe93zPY/kvnKP+6DDBmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hZDJ5wlbwSUcn3ksfVYZUyTAWGNmMkH1NVC3lcHwspUsu8Tq1z25Bdst6OmJ92GKRfVlPgten0Fuif67euRiijIYs+fulo2erhlae6h15BazplOayeWjnsQuU0v8XLZ4r2J65jN44hA+f/1SwIzp8PES8qglhHZl2tnikezv7Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ZRwMdxE; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ZRwMdxE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KG81aPXxrAik1zmnZWcXJ4yv+8a2rraLU/P6GxdRHsF6bUsLJstuz3zuKwQYA7mDTFGU42xZwimkUfKA6PtF9WPj876gVYDIIbJZBmVdFq3p2aSRV1LyC5nuCjxYa9dMoR3HZm67RFipo1WTZNFe2yX5CRcyxKq0T8WCUo1HWeId6EzbrUK1myqLc8hF9qXCsifVh/dmXQcZK5opvSoNA88zNZoRYY50NaNFP1NDwjWj1gnK/fzUFol+jlMqeng6gRZhb5j1LYAR2QKZH/ZSGELyDm2Q4cs7X9sK3EG7sHjR6HeWR0a3WrBotCNmHKWZzWiSdNYGQwECUFt7yyfywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUS+2n8wtJDH8tGWyNAjt7gG1gO/KaQ9S+Zo2iX+6+k=;
 b=xlwU1FuO3gYwBorGCwYBacFQoH/tDQlRBEgjsgG9OFOCfmUoAXSo/A5j3w5QQxjRygTLCW18RkvpMDeszoN1wt7dVtv2sQrdtU2T4w2NoyCWp1kkKbey7NjoZQzEy4ihaw6X9zRojZQU5vVn+wBZooQKUdK7CWMkxbc0CzdcBxFADOnunmIe0zYeCBgfm5QBgcEu9ueipD1PD+b6pAeujqJF9eeZ2gSqE8a8FMIcxQcuKfENzf4WAuStvbgYTSaF70M85AfX1DnJhLzssFN9cVyFT/sa7mRb2AXLq2knrpAxGMa4ezxHIs4ngjVKXOiibF4dvx/48cKNUBjltWYYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUS+2n8wtJDH8tGWyNAjt7gG1gO/KaQ9S+Zo2iX+6+k=;
 b=1ZRwMdxEOsClTmIkT0OjYuoyexgQ0OZuZdiZiNgNYLKX/f02D0ZfSnpvDhfGqprkUO4ETYxxqlgd2JX/VhRwYqRASZus1QB97F6EY/7evNUkG+bvLgOVUNiR+NBwf+Ed5NqP5a9mNaeF9hVd6AbKSYGo1SrqYiE46APtjt5aWoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 15:27:50 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 15:27:50 +0000
Date: Wed, 4 Jun 2025 17:27:45 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v3 5/9] cxl: Defer hardware dport->port_id assignment and
 registers probing
Message-ID: <aEBl8VFAPsWyus1u@rric.localdomain>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <20250521183443.3828320-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521183443.3828320-6-dave.jiang@intel.com>
X-ClientProxiedBy: FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::7) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe67fe7-a982-4c2d-cda2-08dda37c5deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dH5mYf3Zcp6HYPVfCZg6DlzwS9fXMNY9k3mT6CraQAQoVuz26YSaYl7eFEvQ?=
 =?us-ascii?Q?/OAauLpYRx3KRsRZHlX6psQCfRjLYFsKQqoVYaKDzAkOEvsBeg2WNAx8vmJg?=
 =?us-ascii?Q?7I6JO6mPrUomhWCWUqOq5q6ZzhOtTbjnk6qrQn4XonPRw1ERads2yWdPL/7g?=
 =?us-ascii?Q?Se7Kx+SsijvVTeurq1FF9aH1ax5GopXGVAM8tvcGftiG8fOOnuyR4GZtD28h?=
 =?us-ascii?Q?qgs1s6TPDuOZTJH9C7DfPFXv4z3NtEHPShKYYMyJG+uSQGtJlYVY9tmt6YCa?=
 =?us-ascii?Q?0TNc4+Q+rGT0o6557ywTjFzlztH1qD5qjLAjDkVxX3sl/CGyaq/V/A48HDDW?=
 =?us-ascii?Q?t2Tg+m+CiDpdc6qvdWcimQ3xkiwof5ONkOsnjHCNPG+l+MYvxGOWwNl7p9q7?=
 =?us-ascii?Q?ng85/ZUpL/Ml/75fSVggXfItIz2l9Mz+bkqKSJcdvsUsjfvdqqce9TJ/kUKu?=
 =?us-ascii?Q?gXs5ILAOJMQ3u0nS2uU7UVisiDMHoVyRuhwIBnALysSMUw1XV/Xw4MfvYQin?=
 =?us-ascii?Q?8aBkbAZZjGzZX6vb0T++TFNiLxZtKm9vi+qX8e+vjsauje8r36EJrUU1XoIz?=
 =?us-ascii?Q?FqDMekFYlw4ey713mUFSoLg99zW+fWB70jlgAhlTo/JRjB8ZylZQmRA88zE8?=
 =?us-ascii?Q?t5MSlmrez5apYL8RRkQ6E3Hs6Pg+XmOK37cSPP4/kByBT2ekTIpJ7Zd0cv02?=
 =?us-ascii?Q?BzeJ9A+hzVJODEctkqtZPs1s31N0wNv8I1B0rynMRRLSLm88euHjC5n/z6Hm?=
 =?us-ascii?Q?vMYIeRX4lQBe5tCwtZMnpExZlRQkiCe2puhOdxVF3+eSwAlYQjUya712SPuR?=
 =?us-ascii?Q?FuxgEMEPo60eBx3ACWuEHd2Ip1wiTLPj+GErwm+S6hWe7/ZUHDazreCwoHz9?=
 =?us-ascii?Q?y/1IjEzqFi4myHj72Q5Fv4GyoKtoJlCtggOhc2slZ8x7S2dNsP3ev9PQYtWv?=
 =?us-ascii?Q?HESA/LXuVX9bS3AZl1QXzONQlXHe5m8T5vSt8c8G4S2YoZ1yMfqWPSCJ+mXD?=
 =?us-ascii?Q?mkQFOANjVfafFm8CPKMFb+2OjDB883J+eDwAWjD06ueDSkv0DvbCPRKi8Ljy?=
 =?us-ascii?Q?4K+686rilm+QFGS74zO9qx50uH84sqQYj2pUMtkoeE3wrYF8zVQrlModvoWe?=
 =?us-ascii?Q?PM+EbnfymSH0WZ/nOROjTnBMUjZsZJ5ixlfVKmPiGrKGLYXamOhjGwDVUo0O?=
 =?us-ascii?Q?LAw+4ftQV7aIk67/tX/ql3IJdxg5pjPz/w5v1GnzgjEbE0AWu2VEGLMKi9Tg?=
 =?us-ascii?Q?8VBGauxcLa9uJg6vgnhGlVHfshsfEK0RrYt6vWA6yeHswc8P6cbGL5rY34vw?=
 =?us-ascii?Q?+eJTifK5Mve+znKwYV6ppsQoYDtJcFg28d+1t+6urvfakSX/FW2SYQyCWXdt?=
 =?us-ascii?Q?sLomQ4KQ/bk7NNdIbTLBmX83DTtLuAXRgiQNb+Sp/TanvcvTKowpwNEJS4MQ?=
 =?us-ascii?Q?wnDhjsiylLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?atumzp0jeeVmxqGVtyz5dG+Mb/SyW2DujjreqKz97MyE7+Qq522RTUIgbeov?=
 =?us-ascii?Q?S4JtRNznx52Jyq9Vq6b7s7o6zYbsBg0JjqPAPKXWsOlBnxPgNrsiy4VHuNgt?=
 =?us-ascii?Q?P5IkzAqAfxQmeYfOQfxbdsjq3d2d2IAjhQZ0Qe8rgMvZzS2LQNbLAOiCXs6L?=
 =?us-ascii?Q?3PPObIz+J0XWoANSiu7Qk93K1objKTyxtBpscNE8OkYhfviKVHNYib9/pTz8?=
 =?us-ascii?Q?a7LzhXMJbNJWRLIHSUXVAdZsrWOjlNuPw4iz0qAWglJFVt08rFTtsjj7wEtK?=
 =?us-ascii?Q?qfBUZvwmRRHO4A3ZYcsaqr1ToJIoY851wiBUUbsK6z/0RIbMzj2UlC2KCLvh?=
 =?us-ascii?Q?jnrNj8UZD4E9fx3BsuoQ6l1kg9MRWdfakI+ADn+vUlK/2RsonTebnvRSVQzM?=
 =?us-ascii?Q?U42etwMSCA+AUs/VN8ji5h9PCQ7A7KmXSMXmZPDONI3CACnUPOXJXta6b/Gd?=
 =?us-ascii?Q?jpS14YhUWQzi7F9/QVl9jTgdt3hNt5CnDrpkAmBRFdAZvtbV2oQ9eK2hC594?=
 =?us-ascii?Q?oLYJIRScejegSz9QGzAAuZQzDuRxaCQUvIRYMuZY0iHsHdJbrLMClbj1Eg0f?=
 =?us-ascii?Q?ZT/3VW4hzyWnSvXdqEhpYD/X1A/fRZiexjS0MfJrLnEZlVduB/gmxVgABHSR?=
 =?us-ascii?Q?idmyyCM5gteuhVNBjNgdKAUbk4X/DwzFagnprS8IEA9lDHNtWIF3RfmEiHb2?=
 =?us-ascii?Q?Bt5wKVm1CT41ijctp1AxZ0+dqmt3n+6L+7SO4mFJuQ/OTbprr6fXBNlUJXVh?=
 =?us-ascii?Q?2cDRGKJCiCZTJwil++LqS2G9PpAEJYfHmk9CM8xv8fhhogpgQGIQ9KYdJU9Q?=
 =?us-ascii?Q?FgKotiABxhs8vt4dZT1WcJ8csq2VJh1BQHO+wd0WFTY+Wm4zE/vq7R/vnhIR?=
 =?us-ascii?Q?UlPgtsCEp+G9GMWAPNLW4z5QuYfwvrQxma2V22BatwcNdVGuPLIKETMq67CK?=
 =?us-ascii?Q?B750IAkW7+78FHC2nzZJN8xmGpmxzsw2QfWwYC9ZTz9Q2z4nIMYYC46NW8zz?=
 =?us-ascii?Q?l9Cn7HLjkYfr+elNVDtyfpOSmqZ/E3IPjmCASQ8JHlwijuegt0K6V0ko/JpA?=
 =?us-ascii?Q?p18q5VUxH7djY4NXur3luSyce+OfHWb3CK1RPbRpqZGSXDY7BPp+lc+dDnKk?=
 =?us-ascii?Q?LfPZZ9i2ylzmERwS01Y/sAOjS+z1w0KoDuttxAoRT6q+RvoIdoXnHDpmmnYB?=
 =?us-ascii?Q?tie70uEUjVX92OFpdkKRFS5pJsMYN8FD0GlosES+CBvdV0q0t6wanDJSvFg6?=
 =?us-ascii?Q?h5U1ZS78w48pTDhpI0I7SRsKfr3hRMpuZiSWUv1/V6TADBHkA9vK8HvIa9vN?=
 =?us-ascii?Q?jSqIllqHmykPxifLUzf2hZ2J0dH61ngpZy1Kq2l1kljC8nVQXD9QkDx4CeAm?=
 =?us-ascii?Q?PofhVtx3TdAt/UjlVkWxH65HRv9roqfc8eB56HCH23Xg3XNpKWDemjx0PWsh?=
 =?us-ascii?Q?J3vZnLVfb9+cwB3t0mpHKttxkLQCLz26hQJ4+K/qlNkEzD3LzKKu8FZ+YrHa?=
 =?us-ascii?Q?N6trlaNSmVCmg6fPfmxuzn29uG40+2/fVp7daBDFzwSn25i6vehm8pDwKPmz?=
 =?us-ascii?Q?VPaIUchSzj6haaR+y9EmNQJdUepw7y/LetWUxl9J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe67fe7-a982-4c2d-cda2-08dda37c5deb
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 15:27:50.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9wVpfAj76cgbfHQsY3bihuQntk39IRC0Z+EduZh/5KCKkDrUsdq+0e1fZxDe1P3/fXhgAoKqvgnj5fD7hJRAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835

Dave, see inline.

On 21.05.25 11:34:39, Dave Jiang wrote:
> Current implementation only enumerates the dports during the port probe.
> Without an endpoint connected, the dport may not be active during port
> probe. This scheme may prevent a valid hardware dport id to be retrieved
> and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
> dport id assignment and the register probing to behind memdev probe so the
> endpoint is guaranteed to be connected.
> 
> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
> switches) for port creation. cxl_acpi() creates a root port from the
> ACPI0017.N device. Through that it enumerate downstream ports composed
> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
> use add_host_bridge_uport() to create the ports that enumerates the PCI
> root ports as the dports of these ports. Every time a port is created,
> the port driver is attached and drv->probe() is called and
> devm_cxl_port_enumerate_dports() is envoked to enumerate and probe
> the dports.
> 
> The second phase is if there are any CXL switches. When the pci endpoint
> device driver (cxl_pci) calls probe, it will add a mem device and triggers
> the cxl_mem->probe(). cxl_mem->probe() calls devm_cxl_enumerate_ports()
> and attempts to discovery and create all the ports represent CXL switches.
> During this phase, a port is created per switch and the attached dports
> are also enumerated and probed.
> 
> The last phase is creating endpoint port which happens for all endpoint
> devices.
> 
> In this commit, the port create and its dport probing in cxl_acpi is not
> changed. That will be handled in a different patch later on. The behavior
> change is only for CXL switch ports. Only the dport that is part of the
> path for an endpoint device to the RP will be probed and marked as active
> by having a valid dport->port_num. This happens naturally by the code
> walking up the device hierarchy and identifying the upstream device and
> the downstream device.
> 
> Locking of port device wraps the cxl_switch_port_dport_setup() to
> protect modifications against the port and its dports while multiple
> endpoints can be probing at the same time and the same port is being
> modified concurrently.
> 
> The detection of duplicate dport for add_dport() is removed. The port_id
> is not read from the hw at this point any longer. The port->id will always
> be unique since it's retrieved from an ida. The dup detection thus become
> irrelevant. With this behavior, only a dport that points to a valid
> endpoint path would be probed. Of course the decoder enumeration and
> SSLBIS parsing is also delayed until the dport is probed since it needs to
> know the port_num and also be able to read the registers.

The decoders could be still enumerated early, just the target list
needs to be updated later. See also below.

> 
> The decoders must also be updated since previously it's all done when all
> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport. A
> guard(rwsem_write) is used to update decoder targets. This is similar to
> when decoder_populate_target() is called and the decoder programming
> must be protected.
> 
> The success return value of devm_cxl_port_enumerate_dports() has been
> changed to always 0 since no caller is using the return value of dports
> enumerated for anything in the current code now.
> 
> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - port_probe_dport() return dport() directly (Ming)
> - cxl_switch_port_dport_setup() return rc directly. (Ming)
> - Add more explanation in the commit log. (Gregory)
> - Return 0 on success for devm_cxl_port_enumerate_dports. (Jonathan)
> - comment on return !dev_is_pci() for cxl_dport_setup(). (Jonathan)
> - Move retrieving port_num after reading lnkcap. (Jonathan)
> - Optimize port_probe_dport code flow. (Jonathan)
> - Optimize return of decoder setup. (Jonathan)
> ---
>  drivers/cxl/core/core.h |   4 ++
>  drivers/cxl/core/pci.c  |  66 +++++++++++++-----
>  drivers/cxl/core/port.c | 146 +++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h       |   4 ++
>  drivers/cxl/port.c      |  26 +------
>  5 files changed, 189 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 17b692eb3257..8b1d9a8ab852 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -134,4 +134,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>  
> +int cxl_dport_setup(struct cxl_dport *dport);
> +int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
> +			 resource_size_t component_reg_phys);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3b84b43ab194..dd204b6f7032 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -24,6 +24,53 @@ static unsigned short media_ready_timeout = 60;
>  module_param(media_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>  
> +int cxl_dport_setup(struct cxl_dport *dport)

Could you factor that out in a separate patch before this one? That
makes the whole patch smaller and changes easier to review.

> +{
> +	struct device *dport_dev = dport->dport_dev;
> +	struct cxl_port *port = dport->port;
> +	struct cxl_register_map map;
> +	struct pci_dev *pdev;
> +	u32 lnkcap, port_num;
> +	int rc;
> +
> +	/* Skipping for cxl_test since it's platform device */
> +	if (!dev_is_pci(dport_dev))

The check can be moved in front of port_probe_dport().

Maybe initialize it: dport->port_num = dport->id?

> +		return 0;
> +
> +	/*
> +	 * dport->port_id is valid means that dport has been probed and is
> +	 * setup.
> +	 */
> +	if (dport->port_num != CXL_DPORT_NUM_INVALID)
> +		return 0;

Later I am suggesting to create the dport late together with its
activation. port_num would be always valid then.

> +
> +	pdev = to_pci_dev(dport_dev);
> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +				  &lnkcap))
> +		return -ENODEV;
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc) {
> +		dev_dbg(&port->dev, "failed to find component registers\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = cxl_dport_setup_regs(&port->dev, dport, map.resource);
> +	if (rc)
> +		return rc;
> +
> +	if (map.resource != CXL_RESOURCE_NONE) {
> +		dev_dbg(dport->dport_dev,
> +			"Component Register found for dport: %pa\n",
> +			&map.resource);
> +	}
> +
> +	dport->port_num = port_num;

We still need to check for dups of dport->port_num for all dports
connected to dport->port.

> +
> +	return 0;
> +}
> +
>  struct cxl_walk_context {
>  	struct pci_bus *bus;
>  	struct cxl_port *port;
> @@ -37,10 +84,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  	struct cxl_walk_context *ctx = data;
>  	struct cxl_port *port = ctx->port;
>  	int type = pci_pcie_type(pdev);
> -	struct cxl_register_map map;
>  	struct cxl_dport *dport;
> -	u32 lnkcap, port_num;
> -	int rc;
>  
>  	if (pdev->bus != ctx->bus)
>  		return 0;
> @@ -48,22 +92,13 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  		return 0;
>  	if (type != ctx->type)
>  		return 0;
> -	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> -				  &lnkcap))
> -		return 0;
>  
> -	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> -	if (rc)
> -		dev_dbg(&port->dev, "failed to find component registers\n");
> -
> -	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -	dport = devm_cxl_add_dport(port, &pdev->dev, map.resource);
> +	dport = devm_cxl_add_dport(port, &pdev->dev, CXL_RESOURCE_NONE);

All users of devm_cxl_add_dport use CXL_RESOURCE_NONE now, so better
move cxl_dport_setup_regs() out of devm_cxl_add_dport. That also
implies to add a separate code path for the rch/rcrb case to the dport
setup.

>  	if (IS_ERR(dport)) {
>  		ctx->error = PTR_ERR(dport);
>  		return PTR_ERR(dport);
>  	}
>  
> -	dport->port_num = port_num;
>  	ctx->count++;
>  
>  	return 0;
> @@ -73,8 +108,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>   * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
>   * @port: cxl_port whose ->uport_dev is the upstream of dports to be enumerated
>   *
> - * Returns a positive number of dports enumerated or a negative error
> - * code.
> + * Returns 0 on success or a negative error code.
>   */
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port)
>  {
> @@ -101,7 +135,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
>  		return -ENODEV;
>  	if (ctx.error)
>  		return ctx.error;
> -	return ctx.count;
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, "CXL");
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d62008583da2..2b3ec8436d3d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -791,8 +791,8 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>  				   component_reg_phys);
>  }
>  
> -static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
> -				resource_size_t component_reg_phys)
> +int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
> +			 resource_size_t component_reg_phys)
>  {
>  	int rc;
>  
> @@ -1013,7 +1013,7 @@ int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, "CXL");
>  
> -static bool dev_is_cxl_root_child(struct device *dev)
> +bool dev_is_cxl_root_child(struct device *dev)

Keep static.

>  {
>  	struct cxl_port *port, *parent;
>  
> @@ -1030,6 +1030,7 @@ static bool dev_is_cxl_root_child(struct device *dev)
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_NS_GPL(dev_is_cxl_root_child, "CXL");

... and export not needed.

>  
>  struct cxl_root *find_cxl_root(struct cxl_port *port)
>  {
> @@ -1068,19 +1069,9 @@ static struct cxl_dport *find_dport_by_num(struct cxl_port *port, int port_num)
>  
>  static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>  {
> -	struct cxl_dport *dup;
>  	int rc;
>  
>  	device_lock_assert(&port->dev);
> -	dup = find_dport_by_num(port, dport->port_num);
> -	if (dup) {
> -		dev_err(&port->dev,
> -			"unable to add dport%d-%s non-unique port num (%s)\n",
> -			dport->port_num, dev_name(dport->dport_dev),
> -			dev_name(dup->dport_dev));
> -		return -EBUSY;

I think we still need to check for dups of dport->port_num for the
port. That might screw up the target list entries otherwise.

> -	}
> -
>  	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
>  		       GFP_KERNEL);
>  	if (rc)
> @@ -1652,6 +1643,112 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	return rc;
>  }
>  
> +static struct cxl_dport *port_probe_dport(struct cxl_port *port,
> +					  struct device *dport_dev)

If you move that code back to cxl/pci.c and/or cxl/port.c I think the
whole mock dance in the next patch could become obsolete.

> +{
> +	struct cxl_dport *dport;
> +	unsigned long index;
> +	int rc;
> +
> +	device_lock_assert(&port->dev);
> +	xa_for_each(&port->dports, index, dport) {
> +		if (dport->dport_dev != dport_dev)

Just look that up with xa_load aka cxl_find_dport_by_dev.

> +			continue;
> +
> +		rc = cxl_dport_setup(dport);

How about moving dport creation here too and only collect dport_dev
entry in &port->dports with a reference to NULL first meaning it is
not yet initialized. We can then only expose linked dports with real
port_nums in the reference (dportN where N is the port_num). I really
like to see port_num in sysfs.

> +		if (rc)
> +			return ERR_PTR(rc);
> +
> +		return dport;
> +	}
> +
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static int update_switch_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_dport *dport = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_decoder *cxld;
> +	int i;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	cxld = &cxlsd->cxld;
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +	for (i = 0; i < cxld->interleave_ways; i++) {
> +		if (cxlsd->target_map[i] == dport->port_num) {
> +			cxlsd->target[i] = dport;
> +			return 0;
> +		}
> +	}
> +
> +	dev_dbg(dev, "Updating decoder target_map with %s and none found\n",
> +		dev_name(dport->dport_dev));

That message is misleading as there could be multiple decoders
connected to a port and not all dports are used by that one.

> +
> +	return 0;
> +}
> +
> +static int update_decoders_with_dport(struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	device_lock_assert(&port->dev);
> +	return device_for_each_child(&port->dev, dport, update_switch_decoder);
> +}
> +
> +int devm_cxl_port_setup_decoders(struct cxl_port *port)

Please add a separate patch for creating
devm_cxl_port_setup_decoders().

> +{
> +	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
> +	unsigned long index;
> +	int dports = 0;
> +
> +	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> +	if (!IS_ERR(cxlhdm))
> +		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> +
> +	if (PTR_ERR(cxlhdm) != -ENODEV) {
> +		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
> +		return PTR_ERR(cxlhdm);
> +	}
> +
> +	xa_for_each(&port->dports, index, dport)
> +		dports++;

port->nr_dports?

Is the number of dports constant for each port or may it change
depending on hotplug events or enumeration order?

> +
> +	if (dports == 1) {
> +		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
> +		return devm_cxl_add_passthrough_decoder(port);

The dport port_num is not yet available for setting up the passthrough
decoder's target list.

We should ignore cxlsd->target_map[i] and just pre-init
cxlsd->target[i] with the only existing dport for the passthrough
case.

> +	}
> +
> +	dev_err(&port->dev, "HDM decoder capability not found\n");
> +	return -ENXIO;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_port_setup_decoders, "CXL");

Export not needed.

> +
> +static int cxl_switch_port_dport_setup(struct cxl_port *port,
> +				       struct device *dport_dev)
> +{
> +	struct cxl_dport *dport;
> +
> +	device_lock_assert(&port->dev);
> +
> +	if (!port->dev.driver)
> +		return -ENODEV;

This looks fragile and introduces order dependencies. It would be
better to make cxl_switch_port_dport_setup part of the port probe.

> +
> +	dport = port_probe_dport(port, dport_dev);
> +	if (IS_ERR(dport))
> +		return PTR_ERR(dport);
> +
> +	cxl_switch_parse_cdat(port);
> +

This decoder setup looks odd:

> +	/* Make sure that no decoders have been allocated before proceeding. */
> +	if (ida_is_empty(&port->decoder_ida))
> +		return devm_cxl_port_setup_decoders(port);
> +
> +	return update_decoders_with_dport(port, dport);

Why do you combine decoder and dport setup? To me it looks straight to
just allocate dports, then decoders, and later update the dports and
switch decoder target list with the dport activation.

That is, move the update/activation part to endpoint probe, while the
decoder setup is part of the memdev probe here and/or switch port
probe.

> +}
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
> @@ -1700,6 +1797,19 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  				"found already registered port %s:%s\n",
>  				dev_name(&port->dev),
>  				dev_name(port->uport_dev));
> +
> +			/*
> +			 * Attempt to do single pass dport setup by checking here
> +			 * instead of doing it during port creation. Otherwise
> +			 * it still needs to check here for dports that are
> +			 * being probed with a port already created.
> +			 */
> +			scoped_guard(device, &port->dev) {
> +				rc = cxl_switch_port_dport_setup(port, dport_dev);
> +				if (rc)
> +					return rc;
> +			}
> +
>  			rc = cxl_add_ep(dport, &cxlmd->dev);

I suggest to move the dport creation to the port probe and make this
iterator work without dports (which should work as the next port is
just the grandparent).

>  
>  			/*
> @@ -1765,10 +1875,14 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  
>  	guard(rwsem_write)(&cxl_region_rwsem);
>  	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
> -		struct cxl_dport *dport = find_dport_by_num(port, target_map[i]);
> +		struct cxl_dport *dport;
>  
> -		if (!dport)
> -			return -ENXIO;
> +		cxlsd->target_map[i] = target_map[i];
> +		dport = find_dport_by_num(port, target_map[i]);
> +		if (!dport) {
> +			/* dport may be activated later */
> +			continue;
> +		}
>  		cxlsd->target[i] = dport;

Just copy the target_map here, the dport is updated later.

>  	}
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4ba3bbe9600b..6b85d5f23be0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -404,6 +404,7 @@ struct cxl_endpoint_decoder {
>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>   * @cxld: base cxl_decoder object
>   * @nr_targets: number of elements in @target
> + * @target_map: array of expected dport port_id mirror the target
>   * @target: active ordered target list in current decoder configuration
>   *
>   * The 'switch' decoder type represents the decoder instances of cxl_port's that
> @@ -415,6 +416,7 @@ struct cxl_endpoint_decoder {
>  struct cxl_switch_decoder {
>  	struct cxl_decoder cxld;
>  	int nr_targets;
> +	int target_map[CXL_DECODER_MAX_INTERLEAVE];
>  	struct cxl_dport *target[];
>  };
>  
> @@ -906,6 +908,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int devm_cxl_port_setup_decoders(struct cxl_port *port);
> +bool dev_is_cxl_root_child(struct device *dev);

Both seem to be a leftovers, can be kept static.

>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index a35fc5552845..12394f280288 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -59,34 +59,10 @@ static int discover_region(struct device *dev, void *root)
>  
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
> -	struct cxl_hdm *cxlhdm;
> -	int rc;
> -
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  
> -	rc = devm_cxl_port_enumerate_dports(port);
> -	if (rc < 0)
> -		return rc;
> -
> -	cxl_switch_parse_cdat(port);
> -
> -	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> -	if (!IS_ERR(cxlhdm))
> -		return devm_cxl_enumerate_decoders(cxlhdm, NULL);

Why do you move cdat and hdm setup out here? It's unrelated to dport
setup.

Ah, cdat depends on it and cdat_sslbis_handler needs it. Maybe
decouple it same way with cxl_cxims_data and update it with the dport
activation. Then, add it to an *_update_port_num() function.

> -
> -	if (PTR_ERR(cxlhdm) != -ENODEV) {
> -		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
> -		return PTR_ERR(cxlhdm);
> -	}
> -
> -	if (rc == 1) {
> -		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
> -		return devm_cxl_add_passthrough_decoder(port);
> -	}
> -
> -	dev_err(&port->dev, "HDM decoder capability not found\n");
> -	return -ENXIO;
> +	return devm_cxl_port_enumerate_dports(port);
>  }
>  
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
> -- 
> 2.49.0
> 

Thanks,

-Robert
