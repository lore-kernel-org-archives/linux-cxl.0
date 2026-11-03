Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793728471;
	b=Xo3qEe97/sal5w26CaviFKxfM0bLa5ymMhMTLl1hyX7nmy22p717EiBykCBwo4SbwbB/
	 7xUnOn3xBpfu5szQ3rBRljzCqLTljvaFUbTVmLwclB6sB7udMCdSSccsz08zTYiRvhHp5
	 tL+I8brswP0hB94XZu8eGHIDTnrxnMKI1SrrogMSNjRMQ80po5QKSU2C+xjUcN0aW8nVj
	 dbbVTGzXlG7djmpHvni4zgi2+aFVfiH8J43JFkNk4O3EjGQUwGM8W7Ycte6KD5FZUmdHk
	 zYWuxMRKFEzaNtLZ1QUYBTH8sSTAzE7M9OnMmW5Vc9DVOXvTWDPUmC7yN5Nvv/XYjvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728471;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:CC:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UqHB2ehAimWCdvJB/RUQRA+Yt9oWpx+v24rq3shueyE=;
	b=pIwk2DDR79NAgQaBGS0p0hJTKfua8soTluh2GtooI6DtzJzJOrIcfePPzh1L8nhLjNM+
	 lYlXNFfwQW1FN4VEZUre08LESFeIUdTIAf8Fa0VX7UQAbYFrcH9k6PgMcXXkoTBwiXJx8
	 fDtdVcyH4jtCicqYwmGuj76u5i5VH8UEmhkynaYfxE7I+94QmWiOs769BGT/31lJFLXVp
	 B7CAFjHU4oGmK5TjGXsgWiEKm/Vs8i/Hl3bvkk7A3iIEQf4JK44BOF9sV311T8bhVYLwm
	 0ZRK5YFdH+6U66MAAxzd6FHQnFKMB9vvPo/mr3Qwnt4Ir7iJD+XeGvelodZ4LorkgKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MDqpdluF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.64
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD1606A32D
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 17:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EBD1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MDqpdluF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6k3lX+RFz31QvE64qZ8ini1ZGlZnZBnzrNVcKY3AGkQ+ylzvUc6Pb5Vms6c+rd+Wbrp495wrmHzdiwuvn4XQ43oaCfrcbXCmER0WNJ7XkCPpKgMiU2M//B6VP+BtQr9C5IjU+Wm9ybPNkIEUazExybBwc+3CCjFsp+XKR4yxhIwRiepMHfnQSCPAuKQAJ57DQp4HK063UftDzDc7U39Jgg02JQ6bd7uaPYhWrqJR2EFkRn92UpfGQ/1UiKKfvLeGlkCSrx+ZyE17Kr9vdi57ZimynvpG+E9qZ9nqHtaFqx5P7cNNh7xxAMpB4tRIARPQSFUBy2NvWqT2c+Lq+Mbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqHB2ehAimWCdvJB/RUQRA+Yt9oWpx+v24rq3shueyE=;
 b=VRdUzvatyAtLr2pXfYGhKVnUtXXDsAHN0sTH18a0xww6/sdUAQTgDgwByE2ljFIoIjkDsW+Z25qGbKPucofVS7X16mACmn3uyDq6gncVn3KSuwrww9qgTcU7X8rDcWDn9GEg5glUrUoGaTN3F3KKDDnXtcAYaMXBtPhqjYBLW4vHJTLWJNDGhW6jwPn1cIeynLXsXjvnb1oveNaU9GSD4SaoJUM5AtqewZCD9oSC7eQVkyz/WjDkGvT2BRs4zqKBE9LtwquiIf9iGNRxw8B2mDTf2wLIfeU5shXD+d5Pw4+FLz967JTdjhEhVB6P+Z2nk1ohoHo8s9/IO9GycZ+cCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqHB2ehAimWCdvJB/RUQRA+Yt9oWpx+v24rq3shueyE=;
 b=MDqpdluFGXOvn/dwPgPCIcxR/fntYcf9qFYupxE14cR+NEZJ6qeosLFf+r2XfNKyM+Fxv6g5gnJE+o71JZDipVo3MLkJAcBPqDiJsoGgs7Bcl0rJ4Giu5/313u5Q8qh2MhI88Y2h/6/vQNqr8Io8c/dttDNw6FBOkD4I4l8ZBqc=
Received: from SJ0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:2c0::17)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 17:54:26 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3) by SJ0PR13CA0012.outlook.office365.com
 (2603:10b6:a03:2c0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 17:54:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 17:54:26 +0000
Received: from [10.236.179.122] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 11:54:25 -0600
Message-ID: <3c6f4b2b-ca0a-4565-9bad-6f5cd6708fa9@amd.com>
Date: Tue, 3 Nov 2026 11:54:24 -0600
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 1/2] cxl/region: Reject a repeat write of an endpoint
 decoder to targetN
To: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>
CC: <linux-cxl@vger.kernel.org>
References: <3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com>
Content-Language: en-US
In-Reply-To: <3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: a203e8b7-afe4-497a-f52a-08df39d38069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|6133799003|22082099003|56012099006|11063799006|261021121427099003|261102123227099003|261022075727099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003|261022115727099003;
X-Microsoft-Antispam-Message-Info:
	FvTxlD7q21Z7USlPLbyDTGJk1XK/9SKFBgGCbReLygnMtF6QKpN0/0Zldczh0fr0FZif+VW15vVJvo0D+FhSew8jKgDOj4eMKNiVuN0g7CBSzOcBgYiaxe5fpvAv0ZWtYRxg+n7fwmkbISDy27YiNeR67lhrt8La7Ft2SpocD3V2ZNTIkq1oXXU9PsoQ2izj5WsWuVXPpu1rkH45wcM6eP/NSxcCMzXYTx156rSXAEXmT2fZ+Bliqp4/zGpMemWxyZwKQaldN89NnjaWgWDO70oXzKuEk0LZTHIYKb/Kdc/zi7VKLbj+fou519m7Y1D8h2+PGXaCH/TIeMlMZlUNcCSMMnPSRm/h3paelM6c89LONMgAnzFPl+gJNO3IeRnzxdzCpMJMhMx/b5UZB7hfy/mbIThIylllAZk1TEAdxINohXDnvet+7CD+e4I8y63ilvukN+Me838VnlND+THw2BXhCv7o69ixgfWQ2XTKHoFrbovxXPTBkEmahCodjl2xPk02MuZDUYt5tvf5K6lzjySXyvC4IuOoYp7sE1Ad5Ra1Mrq7x3RJVY/wnJ6ZybnmE8rlWozbbuvRi9FY7cmFeI+IfINKmMHaXUOpvXwmcd7WVIm5atspzyURYFZ0cORoIzIxLplvyCDyV0uVLu3gVwP/oz0KIjbFliMZEf02NCwFU76jfTueiw8rPih2fQt8IDKSnuIcRKKJ5jbMN/sZBA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(6133799003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261022115727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8yNpMdRlYMzW7OmLtIL7GsV46HTWcgnKLJDNjXJQio+6YTWukt9AoTTZWJKEWix/eoC4nkJW1RlTyJuxJMdziNrTRl7RSW4oCXQ77oQ4uO5eoep/7CE5uTYyuGX0Li8Y5uwjUmfEfLXSuyTaHK71I4rsY8lV+99wkYeMCGn8zUYyAknCuEmazRP3pRDUAZeCIdthokZKpBnzOayy5CqRBDTNW8LpMk891uqT+EpH1m3NRwj48M/tTeUM1Flyx9m7gwO92aLWPwB96dLrEEvHbH/iZ1QKftrmb+s6x1aQRokobmsfEl/6YmPXFlZqwuQY8bTuGrxf2/UY5l25JSL3YLsSsFlOugk9BghI6q2XldJswr0BWYkA404hDbvYGUQ5ihyiwuhML+NF4EM/s66/YON8IrlThmqrN2kdWdLidOOs8Gdauk9ygmstdQOXJP+d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 17:54:26.4549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a203e8b7-afe4-497a-f52a-08df39d38069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480

On 11/2/2026 3:19 PM, Alison Schofield wrote:
> Writing an endpoint decoder to a region targetN attribute that already
> holds it returns -EBUSY, but leaves the partially populated region in an
> inconsistent state. The targetN attribute still names the decoder, so the
> failed write gives no indication that the region was damaged.
> 
> Filling the remaining target positions can then trigger a NULL pointer
> dereference in cxl_region_setup_targets(). This can be reproduced through
> sysfs:
> 
>     echo $decoder > /sys/bus/cxl/devices/region0/target0
>     echo $decoder > /sys/bus/cxl/devices/region0/target0
>     echo $other_decoder > /sys/bus/cxl/devices/region0/target1
> 
> An existing check recognizes when the decoder already occupies the
> requested position, but does not prevent the attachment from proceeding
> and modifying region state.
> 
> Move the check ahead of the attachment work, so a repeat write fails with
> -EBUSY without modifying region state. The targetN ABI documents EBUSY for
> an occupied position and makes no exception for writing the same decoder.
> 
> Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---

...

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb..90226327e03c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1764,9 +1764,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (p->targets[pos] == cxled)
> -		return 0;
> -
>  	if (p->targets[pos]) {
>  		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
>  		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> @@ -2130,6 +2127,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> +	/* Already at @pos: fail before changing any region state */
> +	if (pos >= 0 && pos < p->interleave_ways && p->targets[pos] == cxled) {

Should this be checking p->targets[pos] != NULL instead? I think it's possible for this
to pass and then the check at the top of cxl_region_validate_position() (in diff above)
fails anyway. Considering the debug statement is the same, I would think the condition
is probably supposed to be the same as well. Then you can also remove the if statement
from cxl_region_validate_position() :).

With that (or without if I'm wrong here):

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

> +		dev_dbg(&cxlr->dev, "position %d already assigned to %s:%s\n",
> +			pos, dev_name(&cxlmd->dev),
> +			dev_name(&cxled->cxld.dev));
> +		return -EBUSY;
> +	}
> +
>  	cxl_region_perf_data_calculate(cxlr, cxled);
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

