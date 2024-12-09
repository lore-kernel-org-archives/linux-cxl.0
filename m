Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00021B1A7
	for <linux-cxl@vger.kernel.org>; Mon,  9 Dec 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746839; cv=none; b=a6qfsweSb+BHUp98+P2rq9jcXxZmsj81WHTpi/Yd5AAe9U0a0edAyA8+Y7+ginlFQdXQ9UvdSFz8DPeRHyd6V41rh7PYfZ5fZwyiVXsEUdWNoGfxilMegkoLbw+WSQMWR5ypCvJPA9Ir5uhJ0rB0u5iYJ6j/qqzHXdQ1S8H7qlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746839; c=relaxed/simple;
	bh=evimT3B2GeukPDkcnMBS/0ADiQHbjVvcltNou3tSBRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e3S5drfZHX42hpG99FR7JZ/ehpxG9qana/kMpSiaoi1vixplWt+oaTSyQNXAW1Xsx9PeBS/eLhT0OXrxrHlDhv1/c3hjH/EV4Nijo5ZaZZk5bjSm+fZhhwG8lwEwT8ps3K6C0ORMwlbz6uowpDAiWPan2HxeBLnF9JM763lLw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y6LS22J3Yz6GCDm;
	Mon,  9 Dec 2024 20:16:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3ADDC140517;
	Mon,  9 Dec 2024 20:20:33 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 13:20:33 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 9 Dec 2024 13:20:33 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [RFC PATCH v2 02/20] cxl: Add Get Supported Features command for
 kernel usage
Thread-Topic: [RFC PATCH v2 02/20] cxl: Add Get Supported Features command for
 kernel usage
Thread-Index: AQHbN6U/J81nE41YpE27MGcYktncwbLYbMGAgAWEZDA=
Date: Mon, 9 Dec 2024 12:20:32 +0000
Message-ID: <d8731dcf87094e7aa2087563c201963c@huawei.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-3-dave.jiang@intel.com>
 <6752463d2710d_250732949d@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6752463d2710d_250732949d@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dan,

>-----Original Message-----
>From: Dan Williams <dan.j.williams@intel.com>
>Sent: 06 December 2024 00:33
>To: Dave Jiang <dave.jiang@intel.com>; linux-cxl@vger.kernel.org
>Cc: dan.j.williams@intel.com; ira.weiny@intel.com; vishal.l.verma@intel.co=
m;
>alison.schofield@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave@stgolabs.net; jgg@nvidia.com; Shiju
>Jose <shiju.jose@huawei.com>
>Subject: Re: [RFC PATCH v2 02/20] cxl: Add Get Supported Features command
>for kernel usage
>
>Dave Jiang wrote:
>> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h) The
>> command retrieve the list of supported device-specific features
>> (identified by UUID) and general information about each Feature.
>>
>> The driver will retrieve the feature entries in order to make checks
>> and provide information for the Get Feature and Set Feature command.
>> One of the main piece of information retrieved are the effects a Set
>> Feature command would have for a particular feature.
>>
>> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>
>> v2:
>> - fix feature entry pointer math.
>> - free mbox_out in cxl_get_supported_features(). (Shiju, Jonathan)
>> - replace sizeof(struct) with feat_size. (Shiju)
>> - replace reserved in feature structs with u8 type. (Shiju)
>> - change cxl_feat_entry->effects to set_effects. (Shiju)
>> - rearrange assigment of cxl_mbox->entries. (Jonathan)
>> - Separate no features from actual error. (Jonathan)
>> - Fix missing kdoc for entries. (Jonathan)
>> ---
>>  drivers/cxl/core/mbox.c      | 178 +++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxlmem.h         |  31 ++++++
>>  drivers/cxl/pci.c            |   4 +
>>  include/cxl/mailbox.h        |   4 +
>>  include/uapi/linux/cxl_mem.h |   1 +
>>  5 files changed, 218 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c index
>> 880ac1dba3cc..4ba56f3d5a65 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -67,6 +67,7 @@ static struct cxl_mem_command
>cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] =3D {
>>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>> +	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD,
>0),
>
>Since this patch is only about internal usage then no need for a
>cxl_mem_commands entry which is the translation from CXL mailbox op-codes
>to user CXL commands ids.
>
>I think ideally CXL features ABI is only ever a fwctl concern. Lets try to=
 see if we
>can get away with never defining a CXL user command code for them.
>
>>  };
>>
>>  /*
>> @@ -790,6 +791,183 @@ static const uuid_t log_uuid[] =3D {
>>  	[VENDOR_DEBUG_UUID] =3D DEFINE_CXL_VENDOR_DEBUG_UUID,  };
>>
>> +static void cxl_free_features(void *features) {
>> +	kvfree(features);
>> +}
>> +
>> +static int cxl_get_supported_features_count(struct cxl_dev_state
>> +*cxlds) {
>> +	struct cxl_mailbox *cxl_mbox =3D &cxlds->cxl_mbox;
>> +	struct cxl_mbox_get_sup_feats_out mbox_out;
>> +	struct cxl_mbox_get_sup_feats_in mbox_in;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	int rc;
>> +
>> +	memset(&mbox_in, 0, sizeof(mbox_in));
>> +	mbox_in.count =3D cpu_to_le32(sizeof(mbox_out));
>> +	memset(&mbox_out, 0, sizeof(mbox_out));
>> +	mbox_cmd =3D (struct cxl_mbox_cmd) {
>> +		.opcode =3D CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>> +		.size_in =3D sizeof(mbox_in),
>> +		.payload_in =3D &mbox_in,
>> +		.size_out =3D sizeof(mbox_out),
>> +		.payload_out =3D &mbox_out,
>> +		.min_out =3D sizeof(mbox_out),
>> +	};
>> +	rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	cxl_mbox->num_features =3D le16_to_cpu(mbox_out.supported_feats);
>
>I think this function should return a positive number of features or a neg=
ative
>error code, more below...

I  added this change in the EDAC CXL features setup and tested fine.

>
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_get_supported_features(struct cxl_dev_state *cxlds) {
>> +	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =3D NULL;
>> +	int remain_feats, max_size, max_feats, start, rc;
>> +	struct cxl_mailbox *cxl_mbox =3D &cxlds->cxl_mbox;
>> +	int feat_size =3D sizeof(struct cxl_feat_entry);
>> +	struct cxl_mbox_get_sup_feats_in mbox_in;
>> +	int hdr_size =3D sizeof(*mbox_out);
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	struct cxl_mem_command *cmd;
>> +	struct cxl_feat_entry *entry;
>> +
>> +	/* Get supported features is optional, need to check */
>> +	cmd =3D
>cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
>> +	if (!cmd)
>> +		return -EOPNOTSUPP;
>> +	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
>> +		return -EOPNOTSUPP;
>> +
>> +	rc =3D cxl_get_supported_features_count(cxlds);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!cxl_mbox->num_features) {
>> +		dev_dbg(cxl_mbox->host, "No CXL features enumerated.\n");
>> +		return 0;
>> +	}
>> +
>> +	struct cxl_feat_entry *entries __free(kvfree) =3D
>> +		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
>> +
>> +	if (!entries)
>> +		return -ENOMEM;
>> +
>> +	max_size =3D cxl_mbox->payload_size - hdr_size;
>> +	/* max feat entries that can fit in mailbox max payload size */
>> +	max_feats =3D max_size / feat_size;
>> +	entry =3D &entries[0];
>> +
>> +	mbox_out =3D kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>> +	if (!mbox_out)
>> +		return -ENOMEM;
>> +
>> +	start =3D 0;
>> +	remain_feats =3D cxl_mbox->num_features;
>> +	do {
>[..]
>> +		rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>> +		if (rc < 0)
>> +			return rc;
>
>Hmm, why "return rc" here, but "goto err" below?
>
>> +		if (mbox_cmd.size_out <=3D hdr_size) {
>> +			rc =3D -ENXIO;
>> +			goto err;
>
>So one of my new code smells for "needs more care" is cases where scoped-
>based-cleanup functions are still mixed with usage of "goto".
>
>In this case there are two dependent things to cleanup on error, "reset
>cxl_mbox->num_features" and "free @entries". So, to eliminate the goto, ho=
w
>about eliminate one of the things to cleanup with something like
>this:
>
>	struct cxl_features {
>		int num_features;
>		struct cxl_feat_entry entries[] __counted_by(num_features);
>	};
>
>	count =3D cxl_get_supported_features_count(cxl_mbox);
>	if (count <=3D 0)
>		return ...
>
>	struct cxl_features *features =3D __free(kvfree) =3D
>	        kvmalloc(struct_size(features, entries, count), GFP_KERNEL);
>
>	features->num_features =3D count;
>
>...and then use "cxl_mbox->features =3D=3D NULL" as your "no features" cas=
e.

I  tried these changes in the EDAC CXL features setup and tested fine.

>
>
>> +		}
>> +
>> +		/*
>> +		 * Make sure retrieved out buffer is multiple of feature
>> +		 * entries.
>> +		 */
>> +		retrieved =3D mbox_cmd.size_out - hdr_size;
>> +		if (retrieved % feat_size) {
>> +			rc =3D -ENXIO;
>> +			goto err;
>> +		}
>> +
>> +		num_entries =3D le16_to_cpu(mbox_out->num_entries);
>> +		/*
>> +		 * If the reported output entries * defined entry size !=3D
>> +		 * retrieved output bytes, then the output package is incorrect.
>> +		 */
>> +		if (num_entries * feat_size !=3D retrieved) {
>> +			rc =3D -ENXIO;
>> +			goto err;
>> +		}
>> +
>> +		memcpy(entry, mbox_out->ents, retrieved);
>> +		entry++;
>> +		/*
>> +		 * If the number of output entries is less than expected, add the
>> +		 * remaining entries to the next batch.
>> +		 */
>> +		remain_feats +=3D copy_feats - num_entries;
>> +		start +=3D num_entries;
>> +	} while (remain_feats);
>> +
>> +	cxl_mbox->entries =3D no_free_ptr(entries);
>> +	rc =3D devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
>> +				      cxl_mbox->entries);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return 0;
>> +
>> +err:
>> +	cxl_mbox->num_features =3D 0;
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>> +
>> +int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const =
uuid_t
>*feat_uuid,
>> +				    struct cxl_feat_entry *feat_entry_out) {
>> +	struct cxl_mailbox *cxl_mbox =3D &cxlds->cxl_mbox;
>> +	struct cxl_feat_entry *feat_entry;
>> +	int count;
>> +
>> +	/* Check CXL dev supports the feature */
>> +	feat_entry =3D &cxl_mbox->entries[0];
>> +	for (count =3D 0; count < cxl_mbox->num_features; count++, feat_entry+=
+)
>{
>> +		if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
>> +			memcpy(feat_entry_out, feat_entry,
>sizeof(*feat_entry_out));
>
>Why copy-out? Would it not be sufficient to just return the index in the
>features->entries[] array?

I  added this change in the EDAC CXL features setup and tested fine.

>
>[..]
>> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h index
>> cc894f07a435..03c4b8ad84c1 100644
>> --- a/include/cxl/mailbox.h
>> +++ b/include/cxl/mailbox.h
>> @@ -50,6 +50,8 @@ struct cxl_mbox_cmd {
>>   *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
>>   * @mbox_mutex: mutex protects device mailbox and firmware
>>   * @mbox_wait: rcuwait for mailbox
>> + * @num_features: number of supported features entries
>> + * @features: list of supported feature entries
>>   * @mbox_send: @dev specific transport for transmitting mailbox command=
s
>>   */
>>  struct cxl_mailbox {
>> @@ -59,6 +61,8 @@ struct cxl_mailbox {
>>  	size_t payload_size;
>>  	struct mutex mbox_mutex; /* lock to protect mailbox context */
>>  	struct rcuwait mbox_wait;
>> +	int num_features;
>> +	struct cxl_feat_entry *entries;
>>  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd
>> *cmd);  };
>>
>> diff --git a/include/uapi/linux/cxl_mem.h
>> b/include/uapi/linux/cxl_mem.h index c6c0fe27495d..bd2535962f70 100644
>> --- a/include/uapi/linux/cxl_mem.h
>> +++ b/include/uapi/linux/cxl_mem.h
>> @@ -50,6 +50,7 @@
>>  	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
>>  	___C(CLEAR_LOG, "Clear Log"),					  \
>>  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
>> +	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),
>	  \
>
>Again, for a patch that claims to be kernel internal only enabling, lets k=
eep it
>internal-only.

Thanks,
Shiju

