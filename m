Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB93E2771;
	Fri, 28 Aug 2026 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904958; cv=fail; b=VnCdqWb6zqYLOG8HD1cehHeHQdvmkHIiCyo13H8Yc2xeYEKQTRVKzx+n/ZprVbfTs70BNDCmkxW7hSoNq11S6MPlM9TZEv6EohiB4UYi6KabQUfGpJc+N8Jn4cNRxVumv1nQE2BIdzxm98S/zFBzPAsIgqogZDOm/aY1cEOAsn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904958; c=relaxed/simple;
	bh=zgguzxrdeahaqTHXfLeeA8Cc33koTfpMjvqggPXvBxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bHAyGVweUM+qa+naBDK3GMKn2bVpikxbg/RpPW/Zv+r8ghaWOUB8/JuPHejjZgCTDQT2nCLIduTRT3dGCUnTxE7zWLKN9IeP7sAcm1tgEFQYquWL7Phrxkg3/9J9kqgdH/onS5PAo7tAK01Xt08i1ONBoNyaV6AY/0vyMsNOUok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SI78kw+M reason="signature verification failed"; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SI78kw+M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNAk3Yuo5caZFQsut+o0979hahHbY4F0/BDjbH0bcQk8HWLhXhai0rvGdZGi/HHQ3o85LXaCw6zDazPOF/FS4MgophBsm8Ubu6zpZWA05yxx/vmlS0bw82tS33SJBaOiG5OBazJrLd95c494JUS5PVIutNyUm8cawXWGG0+xUz082J63esmdYLNJ3JJUKFeGgjGs59Mv2rgRI6d2nO+aJhIOfekMTO0H/9JTo0Xjtqcz6U4nFPOdK4r3zLPKowpZxORwS1SFtia23fe8fyU3t5P8zfYmPlCIZ75xx0EIWobMFk89RxosM38FX8kWoLLaybTksDZtJGjC3gawXvlFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF98T//r+O49FVLe2i7YLSghvUiAdMvDHjWsQgLthuw=;
 b=AB587pqYwi6s84NU2GOWvsMov5XbUOq/abvQVcs8FLDzAdO5FrLkQZqiHTt98bCehKyY0/ieN9607a9L5F3LxZxf4Jecf39HOjvV2un59ACJd2D1HcVxotF9zWOXQInKxpy4MNSMtd7ee8vi7Kr+6RByxk7aAxocHQEr62kB+aeR5AzyFHHvpWnJATgzCpdtNOQWgGMLCTs8cdbh/d7Mmt/oBWGP6p8/38fVTve5BQWrIhiB8knQ2JXqTuCN0QosqzVkB8i2GxFfpxopoBCU0QKMLvNz7efDT//jC3MdF6YTeNzmqzDnSyDcKEV+H+GSPSRr863HSUt2oP9bdDtwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF98T//r+O49FVLe2i7YLSghvUiAdMvDHjWsQgLthuw=;
 b=SI78kw+MTvxKLhiaEjLmDk6wtd1tQSUEGW8g1KXGVDCDrpxRtP0aZM0F9TQn7cVW6uoGzlvh/4Kso2OaaIMGFKvjc2U+Y5UXpB3jfp2Sd4T5EgHavhY9i5vPuyoqhB7oatV6XP19n4uYH/KUqrWRx44rtK5sPDDEjWDDxBNg7ZP+vjPwDLwSOreMTBUMaKVHdCAhnCb98n+Qo1KJMlXwHV0Wu3nX/yLDofdzl0q0iohKcNMMdw74JE3y+cmxQ8kcAC5UjK/Dwx6EoyNM7yrXiYIAvstIwCBS4GNf7yvtwpN/lkl//xLb4/oeo3Carn2Gr89UeGcv1cxCxKqnizsP6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:15:53 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Fri, 28 Aug 2026
 08:15:53 +0000
Date: Fri, 28 Aug 2026 16:15:45 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 1/2] cxl/memdev: add support for mutipf device
Message-ID: <apErJUX77f4x02LH@MWDK4CY14F>
References: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
 <20260821155134.260053-2-alejandro.lucero-palau@amd.com>
 <aov-jfhJtNtZJxlN@MWDK4CY14F>
 <a313b340-9263-4204-b0b2-bc492cf746a4@amd.com>
 <2a7d2d8c-ff02-4f2f-94d8-21d64dd77f82@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a7d2d8c-ff02-4f2f-94d8-21d64dd77f82@amd.com>
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff7ad77-ac5d-41c0-db63-08df04dc9377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|7416014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	l11Dwnt2wDA06IQUa6es2nxUOkz0LJQBBhB3W1ZvE8TDW1xxtLr7BSQGYZeOWK3inbKG1D00DfIlu+JszDVOODgwfS4ZydHGwI2QmWc/wEij8d9C7JGXRnN6tYJaWnnI0Yn6Xp7MVPaROhyR4GB2LkBkwkX6saXPu4RkM4MPNEfVPZ4jNS+rY+tthpRkizOWYVSpkkYA6BBtOUoWFVEwV/q3EIaExPnC9NyuF/g1qzBLler/yHHNmyLkhWU1htAzpE3dk3ZkiehJ5kfW52hqfx9j9leNH5pjLJrGF6H+ZwoV8BGPWE8rW6knjRh99VR89fDp9/tN10VUpCa22ov8J931obNxqLGqpTzAjBp4VyZXXFctC/J7SdcIEpCzWdsO0XrTggMvgpBqoRknW2rhzS6k0OyhDOAnGiNuP1amj0HibkOxMegLSErNufqq37Pt0GmCqLVIXTtrlMRSgyqnMJt/bCkR1D6ELM+54ED7MGidrIBKyK/SWP1midTYeB4jUr2uQ2crcV29fCeuuQt4bPWYQKHLTgksh7crKFvmDqdpy6ndPVsR+4RtbNQxfcD8HZd1gihTJ8iXyIfMdXGGIABFuluHcH98ctLxGbuPeJzJrpfBioMcd32AiLnSj+7Q63RYjo51NqA2HveH2+DsuSdq8+cSTG0GgqgmXZf9RFs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(7416014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ttb5pRDHGIXsBXlMyj3il6W3Zejh557C0AQ8JXzJBfsQSm/RejGDJqFeob?=
 =?iso-8859-1?Q?1j3h9C14gKE/qJFZ2fTsumko2U9zoHjVY8h83W/UdyV26Oe1m2xWuOSli9?=
 =?iso-8859-1?Q?XoiZbLUtsaZRyLhjaL6TjnxoNgxuobahSBFtmAeaPHunY5o/qvUW9YqqwA?=
 =?iso-8859-1?Q?AC8H4KlH+UB34JLGaKjRo3/1yPOTiL3M4xo/vWi+Dx4YZQhYkLmok9uqxo?=
 =?iso-8859-1?Q?MIPEpgwFe+lwI1R9rP07rSxjZg3qzAfL0NM7+9Lx5vKYcCfxx0kK6SBMjx?=
 =?iso-8859-1?Q?plP7cRBw60a0wjIsvZEwXt0VTRA9FdQxNyLEZuZ/RQoHxcQDMapBe2T7wX?=
 =?iso-8859-1?Q?Iza+SZY6xW3Nzx5AWV81YbJYsShGtB0xOPVo9w1jOizGtF6jOg0/MSMNY7?=
 =?iso-8859-1?Q?qD3HgqYmQuPSsSQ0UkZ9pozlH+aMsEsPTk4i3BN+pfg3XZeMqUynBMiTcs?=
 =?iso-8859-1?Q?v5mLArFeeTmFk79dgZL3g3XeZodgyT+QSQAjE4Uaoz4wsxOIKr4cx9x2xw?=
 =?iso-8859-1?Q?iXy5ofgJD6hEHbq6P/kFZLJJCTtu3F/PiIU87EgGGNCFA4H4PPD3TBgUsA?=
 =?iso-8859-1?Q?RHQxGYdvk6SJGEn3oDduPbP8bs//XHLsjGiONcrlozZ5F/NQ/pI8DV8I+x?=
 =?iso-8859-1?Q?AYhrEHvo1kDC0ZklEbwgUSTwaRZ36l+FzJTM73fa/N5gBzkfSLxQn4jXQI?=
 =?iso-8859-1?Q?WG1aST/RlGQGeb+mJ0CBIr3VfQvMe8+A3qNtkJfm8wAO6jbvwYE3+3Efls?=
 =?iso-8859-1?Q?6up7bskmyTpKd4lnMEdvSQyY9nZ11TlU+yvs73flH/KA89nOkiOvRcmxnC?=
 =?iso-8859-1?Q?0f6YMSU0P73KdvyNK1CvSLPChkeTITKbq9AdA2mYSO45nrazUL8A45TTJq?=
 =?iso-8859-1?Q?7/u39E5N+MduCspRfBxmF03iC5oVGZNrAXRIsFfUNGYMhSejsqEMi0i52+?=
 =?iso-8859-1?Q?ZnXPUzZ9TQ7N2oyUCdalAXJjPiYoHjL9TH36VHTqjBwHCa/qsbxDDsXql7?=
 =?iso-8859-1?Q?fgzYI/XquPfpJ5RG3yEoShLVpeJnaU4eOzV25Wfw8WlCM8XBbHBXB9rSb1?=
 =?iso-8859-1?Q?M9rJEL8Xau957HYc3QK14bsN8x2DM4eayQAm2dVhDF9QQTx+XkTM7Nnkeb?=
 =?iso-8859-1?Q?QlsYDwbuinFeCXprNtH9Xp7gosil+3mTOIF+uRMvDYIdiiuP8r4j722LvD?=
 =?iso-8859-1?Q?AVX6HdPYlmZNH/LfrxCK0AisCLQDSn+DB4To497mZ2M+0KeoN2Ni7ymxtC?=
 =?iso-8859-1?Q?EMWbpUkdFQBZfwYO4R4QJYXIcqfTxELmegOQ5irVGJ+EBQ9F4BN/7HCvxA?=
 =?iso-8859-1?Q?A9WcK7h85MlEV+d2Au0F7T2H4sSVWqHKKiUpfx1zJ7n1EpAn5qGkMYkJie?=
 =?iso-8859-1?Q?efh2fAGYPhRBw2UkTdemGUUhA6cPBP6XQTDPC3POQaXYzXreOjmGNjmk61?=
 =?iso-8859-1?Q?Z7VXGFvFYgx3pMlHGBX2CRWUUkw03fz09ZAKJgV0Qumut/IKVNfM4o6GIZ?=
 =?iso-8859-1?Q?JoFra0WqwG5wnBJOxp4XEmiV3Lz5iO68kY/hKS/nnujdiR5ZBOMqxaqSBM?=
 =?iso-8859-1?Q?IixvFb4xKRA+zzXB7GcPR9yEmwF1Hq/tMNT4QpjSmVpmBhQddX9FJLKAXf?=
 =?iso-8859-1?Q?hmkB1Sbi6UCy09IWQMWTac6BZ2ZdqAfomi7wlCYKhNsZn5m47Un+PLSYNI?=
 =?iso-8859-1?Q?9XNRrEIgv6ZfLv4e9abr7Py9mwegLG8jomoq4+84dsaXu9NzOLXXTsMovE?=
 =?iso-8859-1?Q?nYpW2bAUA/E4Gy4YzCCM5ZTA6yPioRs+uuN4DP52yQWxop?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff7ad77-ac5d-41c0-db63-08df04dc9377
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 08:15:52.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+1C80LDi9rgpXPVklc9Bt4KouaBWVFOwFuN/zcsvgEl7qaitJCZyiu92byylL9KADFpzLjQUzLKmFj5WRhVqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190

On Thu, Aug 27, 2026 at 06:44:42PM +0800, Lucero Palau, Alejandro wrote:
> 
> On 25/08/2026 08:37, Lucero Palau, Alejandro wrote:
> > 
> > On 24/08/2026 09:33, Richard Cheng wrote:
> > > On Fri, Aug 21, 2026 at 04:51:33PM
> > > +0800,alejandro.lucero-palau@amd.com wrote:
> > > > From: Alejandro Lucero<alucerop@amd.com>
> > > > 
> > > > A PCI device can present multiple Physical Functions(PFs) but the CXL
> > > > specs restrict to the first one, PF0, the discovery and management of
> > > > CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
> > > > obtain the CXL.mem range to work with somehow.
> > > > 
> > > > Although this could be handled internally by an accelerator/Type2
> > > > driver, it requires to properly handle changes to the CXL mem device,
> > > > mainly its release by the CXL core, but also potential CXL device
> > > > resets. When this release happens, those other PFs need to be
> > > > told about
> > > > it.
> > > > 
> > > > Implement a way for non-PF0 PFs to register/unregister to the memdev
> > > > linked to the PF0 device. At memdev release, trigger the release of
> > > > those non-PF0 PFs devices registered to such memdev from the
> > > > driver they
> > > > are bound to.
> > > > 
> 
> <snip>
> 
> > > I suggest replacing cxl_get_pf0_memdev() and cxl_put_pf0_memdev()
> > > with another
> > > helper, e.g.:
> > > 
> > > int cxl_memdev_link_consumer(struct device *pf0, struct device
> > > *consumer, struct range *range);
> > >   It should live in cxl/core/memdev.c , and the behavior is
> > > something like
> > > 
> > > 1. Find PF0's memdev and take a temp ref.
> > > 2. Lock the memdev
> > > 3. Verify that the memdev is still registered, driver-bound,
> > > attached, and has a valid HPA range
> > > 4. Create a managed devce link via device_link_add(consumer,
> > > &cxlmd->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> > 
> > 
> > Interesting approach.
> > 
> > 
> > Not sure this could do the proper thing though.
> > DL_FLAG_AUTOREMOVE_CONSUMER seems to remove the link, cxlmd->dev in your
> > case, when consume driver unbinds ... but it is the other way what we
> > need. Maybe I do not understand well all the implications with this
> > approach, so let me study it.
> 
> 
> I'm having problems just trying to implement the supposedly basic
> functionality linking the cxlmd device with the non-PF0 device, I mean
> without thinking about potential races with this approach (I think it has
> less problems in this regard than my approach).
> 
> 
> I can use DL_FLAG_AUTOREMOVE_SUPPLIER with the supplier being cxlmd->dev, so
> at device unbinding it can trigger the non-PF0 device unbinding as well. But
> it seems all this link code is quite related to PM, so some checks at link
> creation fail. I have tried using DL_FLAGS_SYNC_STATE_ONLY along with the
> previous one, but another check precludes the link creation if both are used
> (See device_link_flag_is_sync_state_only() ).
> 
> 
> Do you have any advice here?
> 
> 

Hi Alejandro,

Thanks for trying the device-link approach. I wonder what deivce-link eperiment you actually execute ?
Though I don't have your HW, maybe we can discuss on the experiment method ?

From what I can know from the current driver-core behavior is
- DL_FALG_SYNC_STATE_ONLY | DL_FLAG_AUTOREMOVE_SUPPLIER is rejected by design
- a sync-state-only link won't enforce consumer unbind
- DL_FLAG_AUTOREMOVE_SUPPLIER alone is a valid flag combination, so a NULL there depends on runtime state or
  the specific device relationship

You're right that DL_FLAG_AUTOREMOVE_CONSUMER means the link is removed when the consumer driver unbinds.
Now we get it more clear that, the autoremove flag control the liftetime of the link, they don't control supplier-to-consumer unbind direction.

For normal managed device link, driver core unbinds active consumers before unbinding the supplier.
For this case I think DL_FLAG_AUTOREMOVE_CONSUMER is appropriate since the non-PF0 driver creates the dependency during probe and no longer
needs it after that driver unbinds.

But I rethink about linking consumer to cxlmd->dev, memdev is not the object whose lifetime defines whether the returned HPA range is valid.
An open /dev/cxl/memX can keep the memdev object alive even after the EP and region have been torn down.

I am not sure but cxl_region seems like a more accurate supplier, it provides vaid HPA to consumers.

I let GPT sketched the implementation of the API I was thinking about, maybe something like the following.

"""
  int cxl_memdev_link_region_consumer(struct cxl_memdev *cxlmd,
  				    struct device *consumer,
  				    struct range *range)
  {
  	struct device *decoder_dev __free(put_device) = NULL;
  	struct device *region_dev __free(put_device) = NULL;
  	struct cxl_endpoint_decoder *cxled;
  	struct cxl_region_params *p;
  	struct cxl_region *cxlr = NULL;
  	struct cxl_port *endpoint;
  	struct device_link *link;

  	endpoint = cxlmd->endpoint;
  	if (!endpoint)
  		return -EPROBE_DEFER;

  	/*
  	 * Endpoint removal owns region teardown, so this prevents the
  	 * endpoint and its decoder children from disappearing while the
  	 * supplier is being resolved.
  	 */
  	guard(device)(&endpoint->dev);

  	if (!endpoint->dev.driver)
  		return -EPROBE_DEFER;

  	decoder_dev = device_find_child(&endpoint->dev, NULL,
  					first_mapped_decoder);
  	if (!decoder_dev)
  		return -EPROBE_DEFER;

  	cxled = to_cxl_endpoint_decoder(decoder_dev);

  	/*
  	 * Take an independent region-device reference while the decoder to
  	 * region association is protected. The association is revalidated
  	 * below after taking the region device lock.
  	 */
  	scoped_guard(rwsem_read, &cxl_rwsem.region) {
  		cxlr = cxled->cxld.region;
  		if (!cxlr)
  			return -EPROBE_DEFER;

  		region_dev = get_device(&cxlr->dev);
  	}

  	/*
  	 * Serialize link creation against region driver unbind. Without this,
  	 * a link could be added after device_links_busy() has already marked
  	 * the supplier as unbinding and walked its existing consumers.
  	 */
  	guard(device)(region_dev);
  	guard(rwsem_read)(&cxl_rwsem.region);
  	guard(rwsem_read)(&cxl_rwsem.dpa);

  	p = &cxlr->params;

  	if (!region_dev->driver ||
  	    cxled->cxld.region != cxlr ||
  	    p->state != CXL_CONFIG_COMMIT ||
  	    !p->res ||
  	    p->nr_targets != 1)
  		return -EPROBE_DEFER;

  	link = device_link_add(consumer, region_dev,
  			       DL_FLAG_AUTOREMOVE_CONSUMER);
  	if (!link)
  		return -ENXIO;

  	*range = (struct range) {
  		.start = p->res->start,
  		.end = p->res->end,
  	};

  	return 0;
  }
"""

I think it needs more tweaks, but hope it can give you some idea.

The intended ordering is then,

non-PF0 probe -> validate comitted region -> create (consumer, region) managed link -> copy HPA range -> map the PF slice
region teardown -> driver core sees an active/probing consumer -> wait -> unbind the non-PF0 driver -> consumer unmaps its HPA slice -> AUTOREMOVE_CONSUMER removes the link -> region teardown removes the decoder

driver core can manage the device references and drops the supplier lock before forcing consumer unbind.

Does it match the behavior you need ?

Best regards,
Richard Cheng.



