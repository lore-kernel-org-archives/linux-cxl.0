Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305713B0AC4
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684326; cv=none; b=GrqxDQ81YvX6N1LQyCnn1lGcIntFoap7U6ZmVSQDkpCQQpHkjRDAJqnyz1mZRAQ5LqfmH5ifqmuuCVz2cIDxI1NUGBasxMWmwETi/jxbDHYDKQiQAxUNasxOoKGtHG2CL5KmysVjdtkPGbYCW1M5JSd+O3EtWBOdaetyIv1q6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684326; c=relaxed/simple;
	bh=spyqNEtrZIz0DkILpN1L2VqKMvQ3xvACliVKGAIvBAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LSHOwfpnCndNZB3fFc6nfOsNumkgQJUbD/1iCM7ekEK0Z0Y7l3/EHCDl5c53pHzqaLQoMV230nooxUwmARfuF5CzJxBPc6sQeAAVllO5iyjrpg8/62h427ESPGDcNfc6teND/q66n+Ju+5N9DYXpiSwdh2dJ8zohvW4YIVelnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPomTD0X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPomTD0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502971F00893;
	Fri,  5 Jun 2026 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684321;
	bh=sO4FOUaXd1hSDgqrZxgO4Ucg81IMT2ckMdMgn7SlNsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nPomTD0X0pqj/3I8mspw4e3GwgD0IAsIFfVohWcbuMSMe2qB4qu/Ei2Fo5/6h7gV0
	 /X64tKEwItIOnylOjJEiuY0fFlmyTi/6EQElYCoWkXRXr0rTy34SPJAxC4Dni9UOkB
	 zK9qfdMT/pR1nm7hlT9ySL9cjJbs8DmEgoGGtDyXMYYAxFqBz9EvKcR9MwV7t1MO/C
	 xzJvHsaErNDKukBxcXf+3WLnenwXt6M+2LCBgag/TPs7YepSDHIa+9celcVDLNqJxT
	 1fAlUjZHyvpQyPkwIUyHo3lHcYScirOcbx0yboL3yRDU8MGM4E9xCtQQQRX+TupI2d
	 warm5/9vS73kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/test: Verify cmd->size_in before accessing
 payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605181508.3981107-1-dave.jiang@intel.com>
References: <20260605181508.3981107-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 18:32:00 +0000
Message-Id: <20260605183201.502971F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete bounds check in mock_clear_event leads to an out-of-bou=
nds read vulnerability.
- [High] NULL pointer dereferences in mock feature handlers due to bounds c=
hecks being placed too late or missing entirely.
- [High] Out-of-bounds write on the heap in mock handlers due to missing or=
 inadequate output bounds validation.
- [High] Integer overflow in mock_get_log bypasses bounds checks and causes=
 a massive out-of-bounds read.
--

commit 95b18e396910f0c346a2bf6b9e8a26169223eef2
Author: Dave Jiang <dave.jiang@intel.com>
cxl/test: Verify cmd->size_in before accessing payload

Add a check for cmd->size_in before accessing the payload. This prevents
potential dereferencing of a null pointer if size_in is zero.

Link: https://lore.kernel.org/linux-cxl/20260605143748.235271F00893@smtp.ke=
rnel.org/

> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 271c7ad8cc32c..2e9a5f151e983 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -312,12 +312,17 @@ static int mock_get_event(struct device *dev, struc=
t cxl_mbox_cmd *cmd)
> =20
>  static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  {
[ ... ]
> +
> +	if (cmd->size_in < sizeof(*pl))
> +		return -EINVAL;
> +
> +	pl =3D cmd->payload_in;
> +	log_type =3D pl->event_log;

[Severity: High]
This isn't a bug introduced by this patch, but since we are adding a bounds
check here, does it fully protect against out-of-bounds reads?

Later in this function, there is a loop:

tools/testing/cxl/test/mem.c:mock_clear_event() {
    ...
    for (nr =3D 0, handle =3D event_get_clear_handle(log);
         nr < pl->nr_recs;
         nr++, handle++) {
        if (handle !=3D le16_to_cpu(pl->handles[nr])) {
    ...
}

If the user provides a payload where size_in only covers the header (exactly
sizeof(*pl)) but sets nr_recs > 0, won't this loop read past the end of the
cmd->payload_in buffer?

[ ... ]
> @@ -574,14 +579,19 @@ static int mock_gsl(struct cxl_mbox_cmd *cmd)
>  static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cm=
d *cmd)
>  {
[ ... ]
> +
> +	gl =3D cmd->payload_in;
> +	offset =3D le32_to_cpu(gl->offset);
> +	length =3D le32_to_cpu(gl->length);
> +
>  	if (length > cxl_mbox->payload_size)
>  		return -EINVAL;
>  	if (offset + length > sizeof(mock_cel))

[Severity: High]
This isn't a bug introduced by this patch, but is there an integer overflow
in this bounds check?

Both offset and length are u32 variables controlled by the user. If offset =
is
very large and length is small, could offset + length wrap around to a small
number and bypass this check?

This might lead to an out-of-bounds read in the subsequent memcpy():

tools/testing/cxl/test/mem.c:mock_get_log() {
    ...
    memcpy(cmd->payload_out, data + offset, length);
    ...
}

[ ... ]
> @@ -1415,11 +1429,18 @@ static int mock_get_test_feature(struct cxl_mockm=
em_data *mdata,
>  				 struct cxl_mbox_cmd *cmd)
>  {
[ ... ]
> +	if (cmd->size_in < sizeof(*input))
> +		return -EINVAL;
> +
> +	input =3D cmd->payload_in;
> +	offset =3D le16_to_cpu(input->offset);
> +	count =3D le16_to_cpu(input->count);
> +

[Severity: High]
This isn't a bug introduced by this patch, but while this check prevents nu=
ll
pointer dereferences within mock_get_test_feature(), its caller
mock_get_feature() appears to unconditionally dereference cmd->payload_in
before getting here:

tools/testing/cxl/test/mem.c:mock_get_feature() {
    ...
    struct cxl_mbox_get_feat_in *input =3D cmd->payload_in;

    if (uuid_equal(&input->uuid, &CXL_VENDOR_FEATURE_TEST))
    ...
}

If userspace sends a command with size_in =3D 0, will it trigger a panic be=
fore
ever reaching this new check? Similar omissions appear to exist in
mock_set_feature() and mock_get_supported_features().

[Severity: High]
This isn't a bug introduced by this patch, but while looking at bounds
validation in these mock handlers, is there an out-of-bounds write on the
heap in other functions?

For example, mock_get_supported_features() writes to cmd->payload_out witho=
ut
validating that cmd->size_out is large enough:

tools/testing/cxl/test/mem.c:mock_get_supported_features() {
    ...
    out->supported_feats =3D cpu_to_le16(MAX_CXL_TEST_FEATS);
    cmd->return_code =3D 0;
    if (count < struct_size(out, ents, MAX_CXL_TEST_FEATS)) {
        out->num_entries =3D 0;
        return 0;
    }

    out->num_entries =3D cpu_to_le16(MAX_CXL_TEST_FEATS);
    feat =3D out->ents;
    fill_feature_vendor_test(feat);
    ...
}

This function checks the requested input count instead of the actual alloca=
ted
cmd->size_out before writing 48 bytes to the flexible array out->ents.
Similarly, mock_get_poison() copies dynamically sized poison records to
payload_out without checking if cmd->size_out is large enough.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605181508.3981=
107-1-dave.jiang@intel.com?part=3D1
