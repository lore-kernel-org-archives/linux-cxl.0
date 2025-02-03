Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F5202F65
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738585336; cv=none; b=RTVYTE4KdVb9k6VAn29H0ZwLRrTtxqOL8XEtgbwu7wVmUeVwvJcAFIAh5HEek+rKr9pnSlblTSittaHqB6aRFVehbxJLcE8WLIlVusmKvpeWh0Fc1CUwYmESMzvzoaAUlD/rQw6jjaQwMCOfei9BhGNecSqrs3ZvnJOPUyDXXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738585336; c=relaxed/simple;
	bh=zM95cBQWznzB3rrlImqh9u9FEJuZPivTCB7uRs23pKQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9NVE4SYAXw1tiBHQVHhRYKsHJxhA79xnGKBcpA+CPJBLV713UBPQRw1N/IpTfqQCeBTJQc20rQ7GMmHOo4CDKb1IkzkvEjDH3Z14qVYSI45tqYAwZltfqSx5GFNgf/J7SBrzhiss6VqqTtblgEQrxWZMYq4phhTTwnv8nogLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmlwL1FwNz67CtD;
	Mon,  3 Feb 2025 20:21:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D3E8E140B63;
	Mon,  3 Feb 2025 20:22:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 13:22:11 +0100
Date: Mon, 3 Feb 2025 12:22:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v2 04/16] cxl/test: Add Get Supported Features mailbox
 command support
Message-ID: <20250203122210.000055ef@huawei.com>
In-Reply-To: <20250201004459.466499-5-dave.jiang@intel.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
	<20250201004459.466499-5-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 31 Jan 2025 17:41:57 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add cxl-test emulation of Get Supported Features mailbox command.
> Currently only adding a test feature with feature identifier of
> all f's for testing.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>


> +static int mock_get_supported_features(struct cxl_mockmem_data *mdata,
> +				       struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_get_sup_feats_in *in = cmd->payload_in;
> +	struct cxl_mbox_get_sup_feats_out *out = cmd->payload_out;
> +	struct cxl_feat_entry *feat;
> +	u16 start_idx, count;
> +
> +	if (cmd->size_out < sizeof(*out)) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_PAYLOADLEN;
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Current emulation only supports 1 feature
> +	 */
> +	start_idx = le16_to_cpu(in->start_idx);
> +	if (start_idx != 0) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
> +		return -EINVAL;
> +	}
> +
> +	count = le16_to_cpu(in->count);
> +	if (count < sizeof(*out)) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_PAYLOADLEN;
> +		return -EINVAL;
> +	}
> +
> +	out->supported_feats = cpu_to_le16(1);
> +	cmd->return_code = 0;
> +	if (count < sizeof(*out) + sizeof(*feat)) {

struct_size() probably makes sense here as well.

> +		out->num_entries = 0;
> +		return 0;
> +	}
> +
> +	out->num_entries = cpu_to_le16(1);
> +	feat = out->ents;
> +	fill_feature_vendor_test(feat);
> +
> +	return 0;
> +}
> +
>  static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
>  			      struct cxl_mbox_cmd *cmd)
>  {
> @@ -1422,6 +1487,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
>  	case CXL_MBOX_OP_ACTIVATE_FW:
>  		rc = mock_activate_fw(mdata, cmd);
>  		break;
> +	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
> +		rc = mock_get_supported_features(mdata, cmd);
> +		break;
>  	default:
>  		break;
>  	}

