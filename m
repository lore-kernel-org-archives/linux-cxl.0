Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A629540BFD
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360722; cv=none; b=FPDANMCM5pbf/ia2MC8uurygh5hBI6wixl1olt/CbX/jbmyDYlxlopsAzinQZr25HasDM7Y9BoHA/88MUmCDT8vOYfhFbwwF5kI3KKs7ZDJk5eUiuAfQcunsFshsyXpD6gB7Ui3vIybheFHb32r1uBRu5ZiTkpRt32SeesGJMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360722; c=relaxed/simple;
	bh=+6SGyJxaJazwd8ZUYOTduN8A8DUSRk98IHKlaZEO6cQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJsVEXq7g1ZO1sszU21HeR6GJyexGmK2iDIEf4hKI8vDv0fAASpA1rwV4Y4kca+MLMpcA2tULI/40WPNHnlO8ji7lzjtUzhX6vvC7miWZVYee81hObc5b/obH/hBpILDXUXkUqkQ5EtkjNv1yOpWlZqrO3SaygcCFBdnpvQvPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdp670819z6K60P;
	Tue, 20 Feb 2024 00:34:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EA95C140F2F;
	Tue, 20 Feb 2024 00:38:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 16:38:35 +0000
Date: Mon, 19 Feb 2024 16:38:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v4 1/3] hw/cxl/cxl-mailbox-utils: Add support for
 feature commands (8.2.9.6)
Message-ID: <20240219163834.00005d6e@Huawei.com>
In-Reply-To: <20240219150025.1531-2-shiju.jose@huawei.com>
References: <20240219150025.1531-1-shiju.jose@huawei.com>
	<20240219150025.1531-2-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 19 Feb 2024 23:00:23 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get Feature and
> optionally modified using Set Feature.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Hi Shiju,

Sorry I've taken so long to get to this!

Looks good. One small comment inline.

Jonathan

> +
> +/* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
> +static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint32_t count;
> +        uint16_t start_index;
> +        uint16_t reserved;
> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in = (void *)payload_in;
> +
> +    struct {
> +        CXLSupportedFeatureHeader hdr;
> +        CXLSupportedFeatureEntry feat_entries[];
> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
> +    uint16_t index;
> +    uint16_t entry, req_entries;
> +    uint16_t feat_entries = 0;
> +
> +    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> +        get_feats_in->start_index > CXL_FEATURE_MAX) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    req_entries = (get_feats_in->count -
> +                   sizeof(CXLSupportedFeatureHeader)) /
> +                   sizeof(CXLSupportedFeatureEntry);

I'm struggling a bit with the Specification text.
I says that count is
"Count in bytes of the supported Feature data to return in the
output payload."

I suppose that includes the header but it's not entirely clear
to me. Let's go with what we have here unless we get a spec
clarification.

> +    req_entries = MIN(req_entries, CXL_FEATURE_MAX);
> +    index = get_feats_in->start_index;
> +
> +    entry = 0;
> +    while (entry < req_entries) {

Given it's a known set of bounds a for loops should be
easier to read.

       for (index = get_feats_in->start_index;
	    index < req_entries;
	    index++) {
           switch (index) {
	   default:
		__builtin_unreachable();
           }
       }  
> +        switch (index) {
> +        default:
> +            break;
> +        }
> +        index++;
> +        entry++;
> +    }
> +
> +    get_feats_out->hdr.nsuppfeats_dev = CXL_FEATURE_MAX;
> +    get_feats_out->hdr.entries = feat_entries;
> +    *len_out = sizeof(CXLSupportedFeatureHeader) +
> +                      feat_entries * sizeof(CXLSupportedFeatureEntry);
> +
> +    return CXL_MBOX_SUCCESS;
> +}

